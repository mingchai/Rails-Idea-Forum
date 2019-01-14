require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    def current_user
        @current_user ||= FactoryBot.create(:user)
    end
    describe "#new" do
        context 'without user signed in' do
            it 'redirects to a new session page' do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
        end
        context 'with user signed in' do
            before do
                session[:user_id] = current_user.id
            end
            it 'renders the new template' do
                get(:new)
                expect(response).to render_template(:new)
            end
            it 'sets an instance variable to a new Idea instance' do
                get(:new)
                expect(assigns(:idea)).to be_a_new(Idea)
            end
        end
    end

    describe "#create" do
        context 'without a signed-in user' do
            it 'redirects to the new session page' do
                post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
                expect(response).to redirect_to(new_session_path)
            end
        end
        context 'with a signed-in user' do
            before do
                session[:user_id] = current_user.id
            end
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
                it 'associates the idea with the current user' do
                    post(:create, params: {idea: FactoryBot.attributes_for(:idea)})
                    idea = Idea.last
                    expect(idea.user).to eq(current_user)
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

    describe '#edit' do
        context 'without signed-in user' do
            it 'redirects to the show page' do
                idea = FactoryBot.create(:idea)
                get(:edit, params: {id: idea.id})
                expect(response).to redirect_to(new_session_url)
            end
        end
        context 'with signed-in user' do
            before do
                session[:user_id] = current_user.id
            end
            it 'renders the edit page' do
                idea = FactoryBot.create(:idea)
                get(:edit, params: {id: idea.id})
                expect(response).to render_template(:edit)
            end
            it 'sets an instance variable to the found idea' do
                idea = FactoryBot.create(:idea)
                get(:edit, params: {id: idea.id})
                
                expect(assigns(:idea)).to eq(idea)
            end
            it 'redirects to the show page' do
                idea = FactoryBot.create(:idea)
                get(:edit, params: {id: idea.id})
                expect(response).to redirect_to(idea_path)
            end
        end
    end

    describe '#destroy' do
        context 'without signed-in user' do
            it 'redirects to the show page' do
                idea = FactoryBot.create(:idea)
                delete(:destroy, params: {id: idea.id})
                
                expect(response).to redirect_to(new_session_url)
            end
        end
        context 'with signed-in user'
    end


end
