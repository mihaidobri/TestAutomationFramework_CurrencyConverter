import pytest
from selenium.webdriver.chrome.webdriver import WebDriver


@pytest.fixture(scope="session")
def driver():
    driver = WebDriver("resources/chromedriver")
    yield driver
    driver.close()
    driver.quit()
