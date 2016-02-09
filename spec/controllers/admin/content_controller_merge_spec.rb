 require 'spec_helper'

describe Admin::ContentController do
  render_views

  describe 'with admin connection' do

    before do
      Factory(:blog)
      #TODO delete this after remove fixture
      Profile.delete_all
      @user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @user.editor = 'simple'
      @user.save
      @article = Factory(:article)
      @article2 = Factory(:article)
      @article_merged = Factory(:article)
      @article_merged.body += @article2.body
      request.session = { :user => @user.id }
    end

    describe 'merge action' do

      it 'should call the model method that performs merge' do
        art_id = "1"
        art2_id = "2"
        @article.should_receive(:merge_with)
        post :merge, {'id' => art_id, 'merge_with' => art2_id}
      end

      it 'should shows new article' do

        @article.stub(:merge_with => "2")
        post :merge, {'id' => 1, 'merge_with' => 2}

      end

=begin
      it 'should merge two articles' do
        art_id = @article.id
        art2_id = @article2.id
        post :merge, 'id' => art_id, 'merge_with' => art2_id
        response.should render_template('new')
        assigns(:article).should_not be_nil
        assigns(:article).should be_valid
        response.should contain(/body/)
        response.should contain(/extended content/)
      end
=end
    end
  end

end
