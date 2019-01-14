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
    end
end
