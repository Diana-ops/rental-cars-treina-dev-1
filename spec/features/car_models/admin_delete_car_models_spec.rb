require 'rails_helper'

feature 'Admin deletes car models' do
	scenario 'successfully' do
		fiat = Manufacturer.create!(name: 'Fiat')
		cat_a = CarCategory.create!(name: 'A', daily_rate: 50, car_insurance: 50, third_part_insurance: 30)

		car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)
		user = User.create!(email: 'teste@teste.com.br', password: '12345678')
		login_as user, scope: :user

		visit root_path
		click_on 'Modelos de Carros'
		find("a#details-#{car_model.id}").click()

		click_on 'Excluir'

		expect(current_path).to eq car_models_path
		expect(page).to have_content('Nenhum modelo cadastrado')
	end

	scenario 'and keep anothers' do
		fiat = Manufacturer.create!(name: 'Fiat')
		cat_a = CarCategory.create!(name: 'A', daily_rate: 50, car_insurance: 50, third_part_insurance: 30)

		car_model = CarModel.create!(name: 'Uno', year: 2020, manufacturer: fiat, motorization: '1.0', fuel_type: 'Flex', car_category: cat_a)
		car_model_b = CarModel.create!(name: 'Dobles', year: 2050, manufacturer: fiat, motorization: '5.0', fuel_type: 'Flex', car_category: cat_a)


		user = User.create!(email: 'teste@teste.com.br', password: '12345678')
		login_as user, scope: :user

		visit root_path
		click_on 'Modelos de Carros'
		find("a#details-#{car_model.id}").click()
		click_on 'Excluir'

		expect(current_path).to eq car_models_path
		expect(page).not_to have_content('Uno')
		expect(page).to have_content('Dobles')
	end
end
