from pytest_bdd import scenarios, scenario, given, when, then, parsers
from page_objects.currency_page import CurrencyPage


@scenario("../features/currency.feature", "Check default currencies")
def test_first_scenario():
    pass

@given("Currency Converter page is displayed", target_fixture='given_on_page')
def given_on_page():
    pass

@then("I should see US Dollar for Currency I Have by default")
def then_current_currency(driver):
    CurrencyPage(driver).open().check_locator('//*[@id="base_currency_selector"]')

@then("I should see Euro  for Currency I Want by default")
def then_default_currency(driver):
    CurrencyPage(driver).open().check_locator('//*[@id="quote_currency_selector"]')


@scenario("../features/currency.feature", "Check amount for 19th January 2020")
def test_second_scenario():
    pass

@when("I select the date 19th January 2020 from the calendar feature")
def when_select_date(driver):
    CurrencyPage(driver).open().change_calendar(month='01', day='19', year='2020')

@then("I see 0.90146 in the Amount(I want to buy something at this price) check box")
def then_see_amount(driver):
    assert "0.90146" == CurrencyPage(driver).open().change_calendar(month='01', day='19', year='2020').base_amount_input()

@then("I see 0.90146 under Rate Details and under Bid AVG")
def then_see_rate(driver):
    assert "1" == CurrencyPage(driver).open().change_calendar(month='01', day='19',
                                                                     year='2020').quote_amount_input()