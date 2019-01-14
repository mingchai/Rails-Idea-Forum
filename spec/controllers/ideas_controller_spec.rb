require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe "#new" do
        it 'renders the new template' do
            get(:new)
            expect(response).to render_template(:new)
        end
        it 'sets an instance variable to a new Idea instance' do
            get(:new)
            expect(assigns(:idea)).to be_a_new(Idea)
        end
    end

    describe "#create" do
        context 'valid input' do
            it 'sets an instance variable to a new instance of an Idea' do
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})

                expect(assigns(:idea)).to be_a(Idea)
            end
            it 'adds an entry to the db' do
                count_before = Idea.count
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
                count_after = Idea.count

                expect(count_after).to eq(count_before + 1)
            end
            it 'redirects the user to the index, home, or show page' do
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})

                expect(response).to redirect_to(ideas_url)
            end
        end
        context 'invalid inputs' do
            it 'renders the new template' do
                post(:create, params: {idea: FactoryBot.attributes_for(:idea, title: nil)})
                expect(response).to render_template(:new)
            end
        end
    end
end
