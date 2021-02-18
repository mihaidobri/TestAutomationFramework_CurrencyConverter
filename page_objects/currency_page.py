from .base_page import BasePage
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

from page_objects import base_page


class CurrencyPage(BasePage):


    def __init__(self, driver):
        super().__init__(driver)

    def check_locator(self, locator):
        return self.driver.find_element(By.XPATH, locator)

    def change_calendar(self, month, day, year):
        string_date = f"{str(month)}/{str(day)}/{str(year)}"
        element = self.driver.find_element(By.XPATH, '//*[@id="end_date_input"]')
        element.click()
        element.send_keys(string_date, Keys.ENTER)
        return self

    def base_amount_input(self, ):
        time.sleep(1)
        return self.driver.find_element(By.ID, "base_amount_input").get_attribute("value")

    def quote_amount_input(self, ):
        time.sleep(1)
        return self.driver.find_element(By.ID, "quote_amount_input").get_attribute("value")
