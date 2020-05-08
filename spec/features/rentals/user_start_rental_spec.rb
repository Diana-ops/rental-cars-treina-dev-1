require 'rails_helper'

feature 'User start rental' do
	scenario 'successfully by search' do
		manufacturer = Manufacturer.create!(name: 'Fiat')
		car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
		                               car_insurance: 100,
		                               third_part_insurance: 100)
		car_model = CarModel.create!(name: 'Uno', year: 2020, fuel_type: 'Flex',
		                         manufacturer: manufacturer, 
		                         motorization: '1.0', 
		                         car_category: car_category)
		subsidiary = Subsidiary.create!(name: 'ACCENTURE', cnpj: '99.168.496/0001-74', address: 'Rua: Paulista')
		car = Car.create!(license_plate: 'ABC1234', color: 'Branco', 
		              car_model: car_model, mileage: 1,subsidiary: subsidiary)
		customer = Customer.create!(name: 'Fulano Sicrano', 
		                        document: '185.972.440-03', 
		                        email: 'teste@teste.com.br')
		rental = Rental.create!(customer: customer, car_category: car_category,
		                    start_date: 1.day.from_now, 
		                    end_date: 2.days.from_now)
		user = User.create!(email: 'test@test.com.br', password: '12345678')

		login_as user, scope: :user
		visit search_rentals_path(q: rental.code)
		click_on 'Iniciar'
		select car.license_plate, from: 'Carro'
		click_on 'Confirmar locação'

		expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
		expect(page).to have_content(car.license_plate)
		expect(page).to have_content(customer.name)
		expect(page).to have_content(customer.email)
		expect(page).to have_content('Em progresso')
		expect(page).to have_content(user.email)
	end

	scenario 'successfully by select a code' do
		manufacturer = Manufacturer.create!(name: 'Fiat')
		car_category = CarCategory.create!(name: 'A', daily_rate: 100, 
		                               car_insurance: 100,
		                               third_part_insurance: 100)
		car_model = CarModel.create!(name: 'Uno', year: 2020, fuel_type: 'Flex',
		                         manufacturer: manufacturer, 
		                         motorization: '1.0', 
		                         car_category: car_category)
		subsidiary = Subsidiary.create!(name: 'ACCENTURE', cnpj: '99.168.496/0001-74', address: 'Rua: Paulista')
		car = Car.create!(license_plate: 'ABC1234', color: 'Branco', 
		              car_model: car_model, mileage: 1,subsidiary: subsidiary)
		customer = Customer.create!(name: 'Fulano Sicrano', 
		                        document: '185.972.440-03', 
		                        email: 'teste@teste.com.br')
		rental = Rental.create!(customer: customer, car_category: car_category,
		                    start_date: 1.day.from_now, 
		                    end_date: 2.days.from_now)
		user = User.create!(email: 'test@test.com.br', password: '12345678')

		login_as user, scope: :user

		visit root_path
		click_on 'Locações'
		click_on rental.code
		
		click_on 'Iniciar'

		select car.license_plate, from: 'Carro'
		click_on 'Confirmar locação'

		expect(page).to have_content(I18n.l(Time.zone.now, format: :long))
		expect(page).to have_content(car.license_plate)
		expect(page).to have_content(customer.name)
		expect(page).to have_content(customer.email)
		expect(page).to have_content('Em progresso')
		expect(page).to have_content(user.email)
	end
end 
