*** Settings ***
Documentation    Create an account, then check login and personal data
Metadata         ID                           133
Metadata         Automation priority          null
Metadata         Test case importance         Low
Resource         squash_resources.resource
Library          squash_tf.TFParamService
Test Setup       Test Setup
Test Teardown    Test Teardown


*** Test Cases ***
Create an account, then check login and personal data
    [Documentation]    Create an account, then check login and personal data

    &{dataset} =    Retrieve Dataset

    Given I am on the AccountCreation page
    When I fill AccountCreation fields with gender "${dataset}[gender]" firstName "${dataset}[first]" lastName "${dataset}[last]" password "${dataset}[password]" email "${dataset}[mail]" birthDate "${dataset}[birth]" acceptPartnerOffers "${dataset}[offers]" acceptPrivacyPolicy "${dataset}[privacy]" acceptNewsletter "${dataset}[news]" acceptGdpr "${dataset}[gpdr]" and submit
    And I go to the Home page
    And I sign out
    Then I can successfully sign in with email "${dataset}[mail]" password "${dataset}[password]"
    Given The displayed name is "${dataset}[display]"
    Given My personal information is gender "${dataset}[gender]" firstName "${dataset}[first]" lastName "${dataset}[last]" email "${dataset}[mail]" birthDate "${dataset}[birth]" acceptPartnerOffers "${dataset}[offers]" acceptPrivacyPolicy "no" acceptNewsletter "${dataset}[news]" acceptGdpr "no"


*** Keywords ***
Test Setup
    [Documentation]    test setup
    ...                You can define the ${TEST_SETUP} variable with a keyword for setting up all your tests.
    ...                You can define the ${TEST_133_SETUP} variable with a keyword for setting up this specific test.
    ...                If both are defined, ${TEST_133_SETUP} will be run after ${TEST_SETUP}.

    ${TEST_SETUP_VALUE} =        Get Variable Value    ${TEST_SETUP}
    ${TEST_133_SETUP_VALUE} =    Get Variable Value    ${TEST_133_SETUP}
    IF    $TEST_SETUP_VALUE is not None
        Run Keyword    ${TEST_SETUP}
    END
    IF    $TEST_133_SETUP_VALUE is not None
        Run Keyword    ${TEST_133_SETUP}
    END

Test Teardown
    [Documentation]    test teardown
    ...                You can define the ${TEST_TEARDOWN} variable with a keyword for tearing down all your tests.
    ...                You can define the ${TEST_133_TEARDOWN} variable with a keyword for tearing down this specific test.
    ...                If both are defined, ${TEST_TEARDOWN} will be run after ${TEST_133_TEARDOWN}.

    ${TEST_133_TEARDOWN_VALUE} =    Get Variable Value    ${TEST_133_TEARDOWN}
    ${TEST_TEARDOWN_VALUE} =        Get Variable Value    ${TEST_TEARDOWN}
    IF    $TEST_133_TEARDOWN_VALUE is not None
        Run Keyword    ${TEST_133_TEARDOWN}
    END
    IF    $TEST_TEARDOWN_VALUE is not None
        Run Keyword    ${TEST_TEARDOWN}
    END

Retrieve Dataset
    [Documentation]    Retrieves Squash TM's datasets and stores them in a dictionary.
    ...
    ...                For instance, datasets containing 3 parameters "city", "country" and "currency"
    ...                have been defined in Squash TM.
    ...
    ...                First, this keyword retrieves parameter values from Squash TM
    ...                and stores them into variables, using the keyword 'Get Test Param':
    ...                ${city} =    Get Test Param    DS_city
    ...
    ...                Then, this keyword stores the parameters into the &{dataset} dictionary
    ...                with each parameter name as key, and each parameter value as value:
    ...                &{dataset} =    Create Dictionary    city=${city}    country=${country}    currency=${currency}

    ${gender} =      Get Test Param    DS_gender
    ${first} =       Get Test Param    DS_first
    ${last} =        Get Test Param    DS_last
    ${password} =    Get Test Param    DS_password
    ${mail} =        Get Test Param    DS_mail
    ${birth} =       Get Test Param    DS_birth
    ${offers} =      Get Test Param    DS_offers
    ${privacy} =     Get Test Param    DS_privacy
    ${news} =        Get Test Param    DS_news
    ${gpdr} =        Get Test Param    DS_gpdr
    ${display} =     Get Test Param    DS_display

    &{dataset} =    Create Dictionary    gender=${gender}    first=${first}    last=${last}          password=${password}
    ...                                  mail=${mail}        birth=${birth}    offers=${offers}      privacy=${privacy}
    ...                                  news=${news}        gpdr=${gpdr}      display=${display}

    RETURN    &{dataset}
