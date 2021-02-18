from page_objects.currency_page import CurrencyPage
import requests



def test_broken_hypterlinks(driver):
    currency_page = CurrencyPage(driver)
    currency_page.open()
    links = [str(link.get_attribute('href')) for link in currency_page.driver.find_elements_by_css_selector("a")]

    links = [link for link in links if 'http' in link]
    for link in links:
        try:
            status_code = requests.head(link, verify=True, timeout=3).status_code
            assert status_code != 404
        except:
            continue

    return


