require 'rack/test'
require 'rspec'
require 'spec_helper'


RSpec.describe IndexController do
  describe "Resultados Buscados" do
    context "Quando abrir página de resultado da busca" do

      it "Deve mostrar a lista de busca" do
        visit "/search_all?search_type=empresa&value="
        expect(page).to have_content('Resultados Buscados')
      end

      it "Deve mostrar o Como funciona, Sobre e Colaboradores na barra de navegação do resultado da busca por empresas" do
        visit "/search_all?search_type=empresa&value="
        expect(page).to have_link('Como funciona')
        expect(page).to have_link('Sobre')
        expect(page).to have_link('Colaboradores')
      end

      it "Deve mostrar o Como funciona, Sobre e Colaboradores na barra de navegação do resultado da busca por estruturas de pesquisa" do
        visit "/search_all?search_type=centro-pesquisa&value="
        expect(page).to have_link('Como funciona')
        expect(page).to have_link('Sobre')
        expect(page).to have_link('Colaboradores')
      end

    end
  end
end
