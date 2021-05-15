from fastapi import FastAPI

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from crawlers import MomoCrawler, FridayCrawler, IcookRecipe, IcookSearch
    
chrome_options = Options()
#chrome_options.add_argument("--disable-extensions")
#chrome_options.add_argument("--disable-gpu")
#chrome_options.add_argument("--no-sandbox") # linux only
chrome_options.add_argument("--headless")
# chrome_options.headless = True # also works
driver = webdriver.Chrome('./crawlers/chromedriver', options=chrome_options)
momo_crawler = MomoCrawler.MomoCrawler(driver)
friday_crawler = FridayCrawler.FridayCrawler(driver)

app = FastAPI()

def price_per_kg_for_sort(x):
    price_per_kg = x['price_per_kg']
    if price_per_kg == -1:
        return 1000000000
    else:
        return price_per_kg

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/ingredient/{ingredient_name}")
def read_ingredients(ingredient_name: str):
    ingredients = []
    ingredients += momo_crawler.get_ingredient_datas(ingredient_name)
    ingredients += friday_crawler.get_ingredient_datas(ingredient_name)

    ingredients = sorted(ingredients, key=price_per_kg_for_sort)

    return {"ingredients": ingredients}

@app.get("/search-recipe")
def read_item(text: str, page: int):
    return IcookSearch.searchRecipe(text, page)

@app.get("/get-recipe")
def read_item(url: str):
    return IcookRecipe.getRecipe(url)