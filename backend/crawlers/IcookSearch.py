import bs4, requests
from urllib.parse import unquote

def searchRecipe(text, page):
    result = {
        'recipes': []
    }

    icook_search_url = 'https://icook.tw/search/'

    if page == 0:   
        url = icook_search_url + text
    else:
        url = icook_search_url + text + '?page=' + str(page)

    agent = {"User-Agent":"Mozilla/5.0"}

    request_result = requests.get(url, headers = agent)
    soup = bs4.BeautifulSoup(request_result.content, "html.parser")

    search_results = soup.find_all('li', class_ = 'browse-recipe-item')
    page_tabs = soup.find_all('a', class_ = 'pagination-tab-link--number')

    for search_result in search_results:
        recipe_url = search_result.find('a', class_ = 'browse-recipe-link').get('href')
        recipe_url = 'https://icook.tw' + recipe_url
        recipe_name = search_result.find('h2', class_ = 'browse-recipe-name').text
        recipe_name = recipe_name.replace('\n', '').replace(' ', '')
        recipe_description = search_result.find('blockquote', class_ = 'browse-recipe-content-description')
        if recipe_description == None:
            continue
        else:
            recipe_description = recipe_description.text.replace('\n', '').replace(' ', '')
        recipe_ingredients_preview = search_result.find('p', class_ = 'browse-recipe-content-ingredient').text
        recipe_ingredients_preview = recipe_ingredients_preview.replace('\n', '').replace(' ', '')
        recipe_image_url = search_result.find('img', class_ = 'browse-recipe-cover-img').get('data-src')
        recipe_image_url = recipe_image_url.split('url=')[1].split('&width')[0]
        recipe_image_url = unquote(recipe_image_url)

        recipe_item = {
            'url': recipe_url,
            'name': recipe_name,
            'description': recipe_description,
            'url': recipe_url,
            'ingredients_preview': recipe_ingredients_preview,
            'image_url': recipe_image_url
        }

        result['recipes'].append(recipe_item)

    return result