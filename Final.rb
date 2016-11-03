
require 'selenium-webdriver'
require 'test/unit'

#Creating TestCases using Test Unit
class UnitTest1 < Test::Unit::TestCase

#Setting up the browser
def setup
    @browser = Selenium::WebDriver.for:chrome
    @browser.get "https://docs.google.com/forms/d/e/1FAIpQLSeT6MPuoZm8Ks3TUw9j3lTKeUlwvcVseFeear6OF4ey24Q40g/viewform"
	@wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	@textbox = @browser.find_element(:name, "entry.310473641")
	@username = @browser.find_element(:name, "entry.1041466219")
	@dropdown = @browser.find_element(:name, "entry.262759813")
	@textarea = @browser.find_element(:name, "entry.649813199")
	@submit = @browser.find_element(:name, "submit")
	@checkbox_fail = @browser.find_element(:css, "#ss-form > ol > div:nth-child(2) > div > div > div.required-message")
end

#Closing the Browser
def teardown
    @browser.quit
end

#TestCase for pass scenarios
def test_pass
#Testing to find the input element and sending the keys - Varun Gattu
    assert @wait.until {
        @username.displayed?
    }
	@username.send_keys "Varun Gattu"
#Testing to find Textboxes and Clicking - Yes
	assert @wait.until {
        @textbox.displayed?
    }
	@textbox.click
#Testing to find Dropdown and selecting JUnit
	assert @wait.until {
        @dropdown.displayed?
    }
	options = @dropdown.find_elements(:tag_name => "option")
	options.each do |g|
		if g.text == "JUnit"
		g.click
		break
		end
	end
#Testing to find Textarea and sending keys - I Love Doing This.
	assert @wait.until {
        @textarea.displayed?
    }
	@textarea.send_keys "I Love Doing This."
#Testing to find the Submit button and clicking on it
	assert @wait.until {
        @submit.displayed?
    }
	@submit.click
end

#Testcase for Fail scenarios
def test_fail
#Testing to find the Submit button and clicking on it
	assert @wait.until {
        @submit.displayed?
    }
	@submit.click
#Testing to find the error message under Checkboxes and verfiying the error text
	assert @wait.until {
        @checkbox_fail.displayed?
    }
	assert_equal("This should fail", @checkbox_fail.text, "This test fails")
end

end
