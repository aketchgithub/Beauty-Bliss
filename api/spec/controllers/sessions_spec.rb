 require "rails_helper"

# RSpec.describe SessionsController, type: :controller do
#     describe "POST #create" do
#       it "logs in a user successfully" do
#         user = create(:user)
#         post :create, params: { email: user.email, password: user.password }
#         expect(response).to redirect_to(root_url)
#         expect(session[:user_id]).to eq(user.id)
#       end
#     end

#     describe "POST #create" do
#     it "does not log in a user with incorrect credentials" do
#       user = create(:user)
#       post :create, params: { email: user.email, password: "incorrect_password" }
#       expect(response).to render_template(:new)
#       expect(session[:user_id]).to be_nil
#     end
#   end

#    describe "DELETE #destroy" do
#    it "logs out a user successfully" do
#     user = create(:user)
#     session[:user_id] = user.id
#     delete :destroy
#     expect(response).to redirect_to(root_url)
#     expect(session[:user_id]).to be_nil
#    end
#  end

# end
  
 RSpec.describe "Sessions", type: :request do
     let!(:user) { User.create(username: "test_user", password: "sup3r-secret")}

     describe "POST /login" do
        context "with valid username and password" do
            it "returns the logged in user" do
                post "/login", params: { username: user.username, password: user.password }

                expect(response.body).to_json({
                    id: user.id,
                    username: user.username,
                    email: user.email
                })
            end

            it "sets the user ID in the session" do 
                post "/login", params: { username: user.username, password:user.password }
                expect(session[:user_id]).to eq(user.id)
            end
        end

        context "with invalid password" do
            it "returns a 401 (Unauthorized) status code" do
                post "/login", params: { username: user.username, password: user.password }
                
                expect(response).to have_http_status(:unauthorized)
            end

            it "does not set the user ID in the session" do 
                post "/login", params: { username: user.username, password: "123"}

                expect(response).to have_http_status(:unauthorized)
            end

            it "does not set the user ID in the session" do
                post "/login", params: { username: user.username, password: "123" }

                expect(session[:user_id]).to eq(nil)
            end

            it "returns an array of error messages in the body" do
                post "/login", params: { username: "nobody", password: "123" }

                expect(response.body).to include_json({
                    errors: a_kind_of(Array)
                })
            end

            it "returns a 401(Unauthorized) status code " do
                post "/login", params: { username: "nobody"}

                expect(response).to have_http_status(:unauthorized)
            end
        end
    end

    describe "DELETE /logout" do
        context "with a logged in user" do
            before do
                post "/login", params: { username: user.username, pasword: user.password }
            end

            it "returns no content" do
                delete "/logout"

                expect(response).to have_http_status(:no_content)
            end

            it "deletes the user ID from the session" do
                delete "/logout"

                expect(session[:user_id]).to eq(nil)
            end
        end

        context "without a logged in user" do
            it "returns an array of error messages in the body" do
                delete "/logout"

                expect(response.body).to include_json({
                    errors: a_kind_of(Array)
                })
            end

            it "returns a 401 (Unauthorized) status code" do
                delete "/logout"

                expect(response).to have_http_status(:unauthorized)
            end
        end
    end


end
