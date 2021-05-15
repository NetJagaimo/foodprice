import bs4, requests

def getRecipe(url):
    result = {
        'resipe_detail': []
    }
    agent = {"User-Agent":"Mozilla/5.0"}
    request_result = requests.get(url, headers = agent)
    soup = bs4.BeautifulSoup(request_result.content, "html.parser")

    ingredients_groups = soup.find_all('div', class_ = 'group')
    for groups in ingredients_groups:
        group_name = groups.find('div', class_ = 'group-name')
        if group_name:
            group_name = group_name.text
        else:
            group_name = ''
        ingredients = groups.find_all('div', class_ = 'ingredient')

        group_item = {
            'group_name': group_name,
            'ingredients': []
        }

        for ingredient in ingredients:
            ingredient_name = ingredient.find('a', class_ = 'ingredient-search').text
            ingredient_unit = ingredient.find('div', class_ = 'ingredient-unit').text

            ingredient_item = {
                'name': ingredient_name,
                'unit': ingredient_unit
            }
            group_item['ingredients'].append(ingredient_item)
        
        result['resipe_detail'].append(group_item)
    
    return result