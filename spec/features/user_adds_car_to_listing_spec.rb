require 'spec_helper'

feature 'User adds car', %Q{
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
} do
  # ACCECTANCE CRITERIA:
  # * I must specify the color, year, mileage of the car.
  # * Only year from 1980 and above can be specified.
  # * I can optianlly specify a description of the car.
  # * If I enter all of the required information in the required format, the car is recored.
  # * If I do not specify all of the required information in the required formats, the car is not recorded and I am presented with errors.
  # * Upon successfully creating a car, I am redirected so that I can create another car.

  scenario 'add car with all required information' do
    visit root_path
    expect(page).to have_content "Car Listing Index"
    click_link 'Create Car'

    car = FactoryGirl.build(:car)

    fill_in 'Color', with: car.color
    fill_in 'Year', with: car.year
    fill_in 'Mileage', with: car.mileage
    fill_in 'Description', with: car.description
    click_button 'Add Car'

    expect(page).to have_content "New car was successfully created!"
    expect(page).to have_content car.color
    expect(page).to have_content car.year
    expect(page).to have_content 'Create Car'
  end

  scenario 'add car without all required information' do
    visit root_path
    click_link 'Create Car'
    click_button 'Add Car'

    expect_presence_error_for(:color)
    expect_presence_error_for(:year)
    expect_presence_error_for(:mileage)
  end

  scenario 'add car with year less than 1980' do
    visit new_car_path

    car = FactoryGirl.build(:car, year: 1979)

    fill_in 'Color', with: car.color
    fill_in 'Year', with: car.year
    fill_in 'Mileage', with: car.mileage
    fill_in 'Description', with: car.description
    click_button 'Add Car'

    expect(page).to have_content "must be greater than or equal to 1980"
  end

  scenario 'add car with out description' do
    visit new_car_path

    car = FactoryGirl.build(:car, :no_description)
    fill_in 'Color', with: car.color
    fill_in 'Year', with: car.year
    fill_in 'Mileage', with: car.mileage
    fill_in 'Description', with: car.description
    click_button 'Add Car'

    expect(page).to have_content "New car was successfully created!"
    expect(page).to have_content car.color
  end
end

def expect_presence_error_for(attribute)
  within "div.car_#{attribute.to_s}" do
    expect(page).to have_content "can't be blank"
  end
end
