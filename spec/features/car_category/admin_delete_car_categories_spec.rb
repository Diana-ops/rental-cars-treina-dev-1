require 'rails_helper'

feature 'Admin deletes car categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'D', daily_rate: 50, car_insurance: 50, third_part_insurance: 30)

    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Categoria D'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and keep anothers' do
    CarCategory.create(name: 'D', daily_rate: 50, car_insurance: 50, third_part_insurance: 30)
    CarCategory.create(name: 'E', daily_rate: 50, car_insurance: 50, third_part_insurance: 30)

    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Categoria D'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Categoria D')
    expect(page).to have_content('Categoria E')
  end
end
