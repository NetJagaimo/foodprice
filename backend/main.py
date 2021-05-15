from fastapi import FastAPI

from selenium import webdriver
from selenium.webdriver.chrome.options import Options

from crawlers import MomoCrawler, IcookRecipe, IcookSearch
    
chrome_options = Options()
#chrome_options.add_argument("--disable-extensions")
#chrome_options.add_argument("--disable-gpu")
#chrome_options.add_argument("--no-sandbox") # linux only
chrome_options.add_argument("--headless")
# chrome_options.headless = True # also works
driver = webdriver.Chrome('./crawlers/chromedriver', options=chrome_options)
momo_crawler = MomoCrawler.MomoCrawler(driver)

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/ingredient/{ingredient_name}")
def read_ingredients(ingredient_name: str):
    ingredients = momo_crawler.get_ingredient_datas(ingredient_name)

    return {"ingredients": ingredients}

@app.get("/search-recipe")
def read_item(text: str, page: int):
    return IcookSearch.searchRecipe(text, page)

@app.get("/get-recipe")
def read_item(url: str):
    return IcookRecipe.getRecipe(url)