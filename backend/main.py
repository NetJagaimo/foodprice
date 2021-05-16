from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi_cache.coder import JsonCoder

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from crawlers import MomoCrawler, FridayCrawler, IcookRecipe, IcookSearch

import asyncio
from concurrent.futures.thread import ThreadPoolExecutor

import itertools

import aioredis

from starlette.requests import Request
from starlette.responses import Response

from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend
from fastapi_cache.decorator import cache

import nest_asyncio

nest_asyncio.apply()

executor = ThreadPoolExecutor(10)

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def price_per_kg_for_sort(x):
    price_per_kg = x['price_per_kg']
    if price_per_kg == -1:
        return 1000000000
    else:
        return price_per_kg

async def scrape(crawler, ingredient_name, loop):
    results = await loop.run_in_executor(executor, scraper, crawler, ingredient_name)

    return results

def scraper(crawler, ingredient_name):
    results = crawler.get_ingredient_datas(ingredient_name)
    
    return results

@app.on_event("startup")
async def startup():
    redis = await aioredis.create_redis_pool("redis://localhost", encoding="utf8")
    FastAPICache.init(RedisBackend(redis), prefix="fastapi-cache")

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/ingredient/{ingredient_name}")
@cache(expire=3600)
async def read_ingredients(ingredient_name: str):
    chrome_options = Options()
    #chrome_options.add_argument("--disable-extensions")
    #chrome_options.add_argument("--disable-gpu")
    #chrome_options.add_argument("--no-sandbox") # linux only
    chrome_options.add_argument("--headless")
    # chrome_options.headless = True # also works
    driver = webdriver.Chrome('./crawlers/chromedriver', options=chrome_options)
    driver2 = webdriver.Chrome('./crawlers/chromedriver', options=chrome_options)
    momo_crawler = MomoCrawler.MomoCrawler(driver)
    friday_crawler = FridayCrawler.FridayCrawler(driver2)
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    
    crawlers = [momo_crawler, friday_crawler]
    tasks = []
    for crawler in crawlers:
        tasks.append(loop.create_task(scrape(crawler, ingredient_name, loop=loop)))
    ingredients = loop.run_until_complete(asyncio.gather(*tasks))
    
    ingredients = itertools.chain(*ingredients)

    ingredients = sorted(ingredients, key=price_per_kg_for_sort)

    momo_crawler.destroy()
    friday_crawler.destroy()

    return {"ingredients": ingredients}

@app.get("/search-recipe")
def read_item(text: str, page: int):
    return IcookSearch.searchRecipe(text, page)

@app.get("/get-recipe")
def read_item(url: str):
    return IcookRecipe.getRecipe(url)
