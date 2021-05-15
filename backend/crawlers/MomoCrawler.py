import re

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class MomoCrawler:
    def __init__(self, driver):
        self.driver = driver

    def get_ingredient_datas(self, keyword):
        url = f"https://www.momoshop.com.tw/search/searchShop.jsp?keyword={keyword}&searchType=1&cateLevel=0&cateCode=&curPage=1&_isFuzzy=0&showType=chessboardType"

        self.driver.get(url)

        results = WebDriverWait(self.driver, 10).until(
            EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#BodyBase > div.bt_2_layout.searchbox.searchListArea.selectedtop > div.searchPrdListArea.bookList > div.listArea > ul > li'))
        )

        datas = []

        for result in results:
            link = result.find_element_by_css_selector('.goodsUrl').get_attribute('href')
            name = result.find_element_by_css_selector('.prdName').text
            price = int(result.find_element_by_css_selector('.price b').text.replace(',', ''))
            
            kg = self.extract_kg_from_name(name)
            if kg <= 0:
                price_per_kg = -1
            else:
                price_per_kg = round(price / kg, 4)
            
            image_link = result.find_element_by_css_selector('.prdImg').get_attribute('src')

            data = {
                "source": 'momo',
                "link": link,
                "name": name,
                "price": price,
                "kg": kg,
                "price_per_kg": price_per_kg,
                "image_link": image_link
            }

            datas.append(data)

        datas = sorted(datas, key=self.price_per_kg_for_sort)

        return datas

    def extract_kg_from_name(self, name):
        weight_re_results = re.findall(r'\d+(?:公克|g|公斤|kg|台斤)', name)
        
        if not weight_re_results:
            return -1
        else:
            weight = weight_re_results[0]

        kg = 0

        if weight.endswith("公斤") or weight.endswith("kg"):
            kg = float(re.findall(r'\d+', weight)[0])
        elif weight.endswith("公克") or weight.endswith("g"):
            g = float(re.findall(r'\d+', weight)[0])
            kg = g / 1000
        elif weight.endswith("台斤"):
            tw_kg = float(re.findall(r'\d+', weight)[0])
            kg = tw_kg * 0.6

        kg = round(kg, 2)

        return kg

    def price_per_kg_for_sort(self, x):
        price_per_kg = x['price_per_kg']
        if price_per_kg == -1:
            return 1000000000
        else:
            return price_per_kg
    
    def destroy(self):
        self.driver.quit()

if __name__ == "__main__":
    from selenium import webdriver
    from selenium.webdriver.chrome.options import Options
    
    chrome_options = Options()
    #chrome_options.add_argument("--disable-extensions")
    #chrome_options.add_argument("--disable-gpu")
    #chrome_options.add_argument("--no-sandbox") # linux only
    chrome_options.add_argument("--headless")
    # chrome_options.headless = True # also works
    driver = webdriver.Chrome('./chromedriver', options=chrome_options)

    momo_crawler = MomoCrawler(driver)
    datas = momo_crawler.get_ingredient_datas('豬肉')
    for data in datas:
        print(data)
