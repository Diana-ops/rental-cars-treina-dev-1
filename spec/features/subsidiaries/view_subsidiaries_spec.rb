require 'rails_helper'

feature 'View subsidiaries' do

	before :each do
		user = User.create!(email: 'teste@teste.com.br', password: '12345678')
		login_as user, scope: :user
	end

	scenario 'successfully' do
		Subsidiary.create!(name: 'ACCENTURE', cnpj: '99.168.496/0001-74', address: 'Rua: Paulista')
		Subsidiary.create!(name: 'ACCIONA', cnpj: '85.171.517/0001-04', address: 'Rua: Masp')

		visit root_path
		click_on 'Filiais'
		
		expect(page).to have_content 'ACCENTURE'
		expect(page).to have_content 'ACCIONA'
	end

	scenario 'and return to home page' do

	    	visit root_path
	    	click_on 'Filiais'
	    	click_on 'Voltar'

	    	expect(current_path).to eq root_path
	end

	scenario 'view subsidiary details' do
		Subsidiary.create!(name: 'ACCENTURE', cnpj: '99.168.496/0001-74', address: 'Rua: Paulista')

		visit root_path
		click_on 'Filiais'
		click_on 'ACCENTURE'

		expect(page).to have_content 'ACCENTURE'
		expect(page).to have_content '99.168.496/0001-74'
		expect(page).to have_content 'Rua: Paulista'	
	end	
	

	scenario 'empty list' do

	    	visit root_path
	    	click_on 'Filiais'

	    	expect(page).to have_content('Nenhuma filial cadastrada')
	end
end
