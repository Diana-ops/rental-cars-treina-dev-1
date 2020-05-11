require 'rails_helper'

feature 'User can not' do
	before :each do
		subsidiary = create(:subsidiary, name: 'AB Carros')
		user = User.create!(email: 'teste@teste.com.br', password: '12345678')
		login_as user, scope: :user
	end

	scenario 'register valid subsidiary' do

		visit root_path
		click_on 'Filiais'

		expect(page).to have_content('AB Carros')
		expect(page).not_to have_link 'Cadastrar uma filial'
	end

	scenario 'edit subsidiary' do

		visit root_path
		click_on 'Filiais'
		click_on 'AB Carros'

		expect(page).not_to have_link 'Editar'
	end
	scenario 'delete subsidiary' do

		visit root_path
		click_on 'Filiais'
		click_on 'AB Carros'

		expect(page).not_to have_link 'Excluir'
	end
end

