Feature: Check Converter page default currencies
        Assuming the following business logic : "Euro" is the default currency for "Currency I Have"
                                                "US Dollar" is the default currency for "Currancy I Want"
                                                and many other logics inferred form the current default behaviours

    Background: 
        Given Currency Converter page is displayed

    Scenario: Check default currencies    
        Then I should see US Dollar for Currency I Have by default
        Then I should see Euro  for Currency I Want by default

    Scenario: Check amount for 19th January 2020
        When I select the date 19th January 2020 from the calendar feature
        Then I see 0.90146 in the Amount(I want to buy something at this price) check box
        Then I see 0.90146 under Rate Details and under Bid AVG


    Scenario: Check Flip Currency functionality
         When I select the date 19th January 2020 from the calendar feature
         And I click on the Flip Currency button
         Then I see 0.82823 in the Amount(I have this much to exchange) box
         And I see 0.82823 under Rate Details and under Bid AVG 


    Scenario : Check Traveler's Cheatsheet tab
         When I select the date 19th January 2020 from the calendar feature
         And I click on the Traveler's Cheatsheet tab
         Then the date 19th January 2020 is displayed with the Interbank Rate +/- 0%
         And 1 USD values 0.83 EUR


    Scenario : Check Traveler's Cheatsheet - print functionality
         When I select the date 19th January 2020 from the calendar feature
         And I click on the Traveler's Cheatsheet tab
         And I click on the "print a copy" link
         Then a print window is opened with accuracte information mathcing the UI numbers


    Scenario : Check Recent Trends - selected day information
         When I select the date 19th January 2020 from the calendar feature
         And I hover the mouse over the chart from Recent Trends coreponding to the date 19th January 2020
         Then I see on top-right of the chart the following information : Jan 19, 2021: 0.8254 


    Scenario : Check Recent Trends - extended interval
         When I select the date 19th January 2020 from the calendar feature
         And I check 60 days or 90 days button from the Recent Trends chart
         Then I see the chart to be extented 
         And the houver-mouse information over the chart for for the selected date is :  Jan 19, 2021: 0.8254  

    Scenario : Check Recent Trends - Interactive interval
         When I select the date 19th January 2020 from the calendar feature
         And I check 60 days or 90 days button from the Recent Trends chart
         Then I see the chart to be extented 
         And the houver-mouse information over the chart for for the selected date is :  Jan 19, 2021: 0.8254


    Scenario : Check Recent Trends - extended interval
         When I select the date 19th January 2020 from the calendar feature
         And I check 60 days or 90 days button from the Recent Trends chart
         Then I see the chart to be extented 
         And the houver-mouse information over the chart for for the selected date is :  Jan 19, 2021: 0.8254  


    Scenario : Check Recent Trends - Interactive Graph
         When I select the date 19th January 2020 from the calendar feature
         And I click on the "Interactive Graph" link
         Then a new tab is opened with a large chart corresponding with the information on the previous tab


    Scenario : Calculate Interbank rate is applied correclty
        When I select the date 19th January 2020 from the calendar feature
        And I select the Interbank interval "1%
        Then the ammount-rate for the "I want to buy" is change to "0.81995"


    Scenario Outline :  Equivalence and Boundary Value testing for interbank rate
        When I select the date 19th January 2020 from the calendar feature
        When I introduce the interbank value : <introduced-value-interbank>
        Then I get the default : <expected-interbank-value> and for I want to buy somehting the amount rate is <computed-ammount-rate>  
        Examples:
            | introduced-value-interbank | expected-interbank-value | <computed-ammount-rate> |
            |               -1%          |           0%             |       0.82489           |
            |                1%          |           0%             |       0.81995           |                       
            |                88%         |           88%            |       0.09899           |
            |                121%        |           99.99%         |       0.00008           |
            |                -a%         |           -              |       0.09899           |

    
    Scenario: Check that the interbank rate displayes error message for invalid entered value
        When I select the date 19th January 2020 from the calendar feature
        And I introduce the interbank value : "a%" 
        Then I get the message "Warning: USD/EUR exchange rates not available for Tuesday, Jan 19, 2021"

    Scenario: Check that the AVG Bid/Ask information is displayed and computed correctly
        When I select the date 19th January 2020 from the calendar feature
        And I execute Javascript On Chrome to get the Network information 
        Then I compute and compare the information from the Json with the information from the UI 

     
    Scenario: Check that ammount boxes can not have more than 15 digits
        When I select the date 19th January 2020 from the calendar feature  
        And attempt to enter 999,999,999,999,999,999 in the amount boxes
        Then the completion will stop at the first 15 digits


    Scenario : Check Traveler's Cheatsheet print functionality
         When I select the date 19th January 2020 from the calendar feature
         And I hover the mouse over the chart from Recent Trends coreponding to the date 19th January 2020
         Then I see on top-right of the chart the following information : Jan 19, 2021: 0.8254 


    Scenario: Check amount input search functionality
        When I input "Australian" in the Amount(I have this much to exchange) box
        Then I see only "Australian Dollar" and  currency in the currency drop down list
        Then the chart is updated
        Then I see "AUD" in <placeholder>
 
        Examples:
            | amount box          | input-search | currency-result    | page-section |
            | Quate ammount input | Australian   | Australian Dollar  | Rate Details - info details  |
            | Base ammount input  | Canadian     | Canadian Dollar    | Rate Details - info details  |


    Scenario: Check default dates
        When I select the date 19th January 2020 from the calendar feature
        Then the date from the "Rate Details" info subtitle is reflecting January 18th 2020
        Then the Recent trends chart is updated accordngly


    Scenario: Check the print functionality
        When I click on "print button" under the Historical Exchange Rates hyperlink
        Then a system window to Print the file is displayed


    Scenario outline: Favorite currencies keeps the last 5 currencies used
        When I click on <currency-type> 
        And I click on <currency>
        Then the drop down <currency-type> in the Favorites section, displays last 5 currencies used

        Examples:
            | currency-type   | currency |
            | Currency I have |   BYN    |
            | Currency I have |   ALL    |
            | Currency I have |   BRL    |
            | Currency I have |   BSD    |
            | Currency I have |   FJD    |
            | Currency I want |   BYN    |
            | Currency I want |   ALL    |
            | Currency I want |   BRL    |
            | Currency I want |   BSD    |
            | Currency I want |   FJD    |


    Scenario outline: Currencies are displayed in alphabetical order and marked with *
        When I click on <currency-type> drop down list and scroll throught the list
        Then the currencies are sorted in alphabetical order from <sorted-type>
        And the currencies name and code is according to "ISO 4217" standard and 'https://www1.oanda.com/currency/iso-currency-codes/'
        And the obsolete or replaced currencies are marked with "*"
        And proper flag icon is displayed

        Example:
            | currency-type   | sorted-type |
            | Currency I have |   A - Z     |
            | Currency I want |   A - Z     | 


    Scenario: Verify the number of currencies
        When I inspect the "I have" drop down there are 201 currencies
        Then I inspect the "I want" drop down and the number of currencies are matching the number of curriencies from "I have" drop down
    

    Scenario : Verify calendar box buttons
        When I click on the calendar "date_rewind" button and "date_forward" button
        Then I am able to navigate to a one previous date or to one future date


    Scenario: Verify calendar last next year button
        When I click on the calendar button
        And I click on the "calendar NavButton-LastYear" button
        Then the "calendar NavButton-NextYear" button is displayed


    Scenario: Verify calendar next year button
        When I click on the calendar button
        And navigate to Jan 1, 1990 
        Then the "calendar NavButton-NextYear" button is not displayed


    Scenario: Verify calendar functionalies
        When I click on the calendar button
        And navigate to Jan 1, 2020
        And click on the current date from the bottom of the calendar 
        Then the calendar is swiching to the current date


    Scenario : Verify future calendar dates are grayed out
        When I click on the calendar button
        And attempt to select a future date
        Then the future dates are grayed out and I am unable to change the current date into a future date


    Scenario Outline : Verify old/future calendar dates are rejected by the calendar
        When I click on the calendar input box
        And attempt to input a  <type-date> , <MM/DD/YYYY> and hit Enter key
        Then the future date resets to the <expected-date>

        Examples:
            | <type-date>  | <MM/DD/YYYY> | expected-date |
            | future-date  | 01/21/2029   | current-date  |
            | old-date     | 01/21/1980   | 01/01/1990    |            


    Scenario : Verify last exchange rate avaialble for modern currencies
        When I select "
        When I click on the calendar button
        And select last avaialble date "Jan 1, 1990"
        Then a tooltip warning message will be displayed : ""


    Scenario : Verify EURO launch date is prior to 1 January 1999
        When I select from the calendar the date "01/01/1998"
        Then I receive the warning message "Warning: USD/EUR exchange rates not available for Thursday, Jan 1, 1998"
        Then Rate Details is showing the "-" sign for EURO unde the USD/EUR Details as well under the BID/ASK section

    
    Scenario : Verify OANDA uses cookies message
        When I am on the Currency Converter page for the first time
        Then I receive on top of the screen the cookies info message :"OANDA uses cookies to make our websites easy to use and customized to our visitors."


    Scenario Outline: Verify the placement of the visual/text elements
        When I navigate am on the <page-position> of the webpage
        Then I see the following <element/menu/hyperlink>

        Examples:
            | <page-position> | element/menu/hyperlink/message |
            |       top       |     OANDA colored logo |
            |       top       |        TRADING         |
            |       top       |     CURRENCY CONVERTOR |
            |       top       |        FX PAYMENTS     |
            |       top       |     CURRENCY CONVERTOR |
            |       top       |        RESOURCES       |
            |     bottom      | OANDA black white logo |
            |     bottom      |       TERMS OF USE     |
            |     bottom      |        PRIVACY POLICY  |
            |     bottom      |          SITEMAP       |
            |     bottom      |Trading FX warning message|


    Scenario: Check Number of Languages avaialble
        When I click on "EN" english on top right corner of the page
        Then are displayed 8 Languages


    Scenario Outline: Change language of the page
        When I change the language to <placeholder-language>
        Then the web page content is change accordingly 

        Examples:
            | placeholder-language | 
            | DE |
            | ES |
            | FR |
            | IT |
            | PT |
            | PY |
            | CH |
            | JP |                     

    Scenario Outline: Verify warning messages
        When I select the date <selected-date>
        And I type the currency <selected-currency> in the <amount-input-box>
        Then I see the popup warning message : <warning-message>

        Examples:
            | <selected-date> | <selected-currency> | amount-input-box    | warning-message |
            | 01/21/2021      | GHC                 | quote_amount_input  | "Warning: GHC Ghanaian Cedi is obsolete and no longer legal tender."           |
            | 01/21/2021      | ADF                 | quote_amount_input  | "Warning: ADF Andorran Franc is replaced by the Euro. Read more about the Euro"|
            | 01/21/1994      | ROL                 | quote_amount_input  | "Warning: ROL/USD exchange rates not available for Tuesday, Jan 21, 1994"      |
            | 01/21/2021      | GHC                 | base_amount_input   | "Warning: GHC Ghanaian Cedi is obsolete and no longer legal tender."           |
            | 01/21/2021      | ADF                 | base_amount_input   | "Warning: ADF Andorran Franc is replaced by the Euro. Read more about the Euro"|
            | 01/21/1994      | ROL                 | base_amount_input   | "Warning: ROL/USD exchange rates not available for Tuesday, Jan 21, 1994"      |
            