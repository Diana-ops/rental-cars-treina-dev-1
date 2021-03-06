require 'rails_helper'

feature 'User search customer' do
  before :each do
    user = create(:user)
    login_as user, scope: :user
  end

  scenario 'by exact name' do
    customer = Customer.create!(name: 'Fulano Sicrano',
                                email: 'fulano@email.com',
                                document: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva',
                                        email: 'joao@dasilva.com',
                                        document: '581.280.655-13')

    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.name
    click_on 'Buscar'

    expect(page).to have_link 'Voltar'
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end

  scenario 'by exact CPF' do
    customer = Customer.create!(name: 'Fulano Sicrano',
                                email: 'fulano@email.com',
                                document: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva',
                                        email: 'joao@dasilva.com',
                                        document: '581.280.655-13')

    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: customer.document
    click_on 'Buscar'

    expect(page).to have_link 'Voltar'
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end

  scenario 'and cannot be blank' do
    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: ''
    click_on 'Buscar'

    expect(page).to have_link 'Voltar'
    expect(page).to have_content('Nenhum resultado encontrado para:')
  end

  scenario 'by partial name' do
    customer = Customer.create!(name: 'Fulano Sicrano',
                                email: 'fulano@email.com',
                                document: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva',
                                        email: 'joao@dasilva.com',
                                        document: '581.280.655-13')

    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'Fulano'
    click_on 'Buscar'

    expect(page).to have_link 'Voltar'
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end
  scenario 'finds nothing' do
    customer = Customer.create!(name: 'Fulano Sicrano',
                                email: 'fulano@email.com',
                                document: '116.801.156-69')
    another_customer = Customer.create!(name: 'João da Silva',
                                        email: 'joao@dasilva.com',
                                        document: '581.280.655-13')

    visit root_path
    click_on 'Clientes'
    fill_in 'Busca', with: 'Larissa'
    click_on 'Buscar'

    expect(page).to have_link 'Voltar'
    expect(page).to have_content('Nenhum resultado encontrado para: Larissa')

    expect(page).not_to have_content(customer.name)
    expect(page).not_to have_content(customer.email)
    expect(page).not_to have_content(customer.document)
    expect(page).not_to have_content(another_customer.name)
    expect(page).not_to have_content(another_customer.email)
    expect(page).not_to have_content(another_customer.document)
  end
end
