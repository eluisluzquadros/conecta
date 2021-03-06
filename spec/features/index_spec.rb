require 'rack/test'
require 'rspec'
require 'spec_helper'

RSpec.describe IndexController do
  describe "Index" do
    context "Quando abrir página principal" do

      before :each do
        visit "/"
      end

      it "Deve mostrar a imagem do logo" do
        expect(page).to have_css('div', class: 'LogoHome')
      end

      it "Deve exibir o campo de busca" do
      expect(page).to have_css('input', class: 'InputSearch')
      end

      it "Deve exibir o texto do copyright no footer" do
        expect(page).to have_content "© 2017 LIGA, Todos os direitos reservados."
      end

      it "Deve exibir o botão login na navbar" do
        expect(page).to have_css('a', id: 'login')
      end

      context "Quando clicar no campo de busca" do

        before :each do
          visit "/"
        end

        it "Deve exibir os filtros de pesquisa" do
          page.find_by_id('InputSearch').click
          expect(page).to have_css('.DropdownMenu')
        end

      end
    end
  end
end
