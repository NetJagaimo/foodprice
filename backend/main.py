from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from crawlers import MomoCrawler, FridayCrawler, IcookRecipe, IcookSearch

import asyncio
from concurrent.futures.thread import ThreadPoolExecutor

executor = ThreadPoolExecutor(10)

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

async def scrape(crawler_name, ingredient_name, loop):
    results = await loop.run_in_executor(executor, scraper, crawler_name, ingredient_name)

    return results

def scraper(crawler_name, ingredient_name):
    if crawler_name == 'momo':
        results = momo_crawler.get_ingredient_datas(ingredient_name)
    elif crawler_name == 'friday':
        results = friday_crawler.get_ingredient_datas(ingredient_name)
    
    return results

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/ingredient/{ingredient_name}")
def read_ingredients(ingredient_name: str):
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    
    crawlers = ['momo', 'friday']
    tasks = []
    for crawler in crawlers:
        tasks.append(loop.create_task(scrape(crawler, ingredient_name, loop=loop)))
    ingredients = loop.run_until_complete(asyncio.gather(*tasks))

    return {"ingredients": ingredients}

@app.get("/search-recipe")
def read_item(text: str, page: int):
    return IcookSearch.searchRecipe(text, page)

@app.get("/get-recipe")
def read_item(url: str):
    return IcookRecipe.getRecipe(url)
