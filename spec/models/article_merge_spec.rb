# coding: utf-8
require 'spec_helper'

describe Article do

  before do
    @blog = stub_model(Blog)
    @blog.stub(:base_url) { "http://myblog.net" }
    @blog.stub(:text_filter) { "textile" }
    @blog.stub(:send_outbound_pings) { false }

    Blog.stub(:default) { @blog }

    @articles = []
    @article = Factory(:article)
    @article_comment = Factory(:comment, :article => @article)
    @article2 = Factory(:article)
    @article2_comment = Factory(:comment, :article => @article2)
    @article2_comment2 = Factory(:comment, :article => @article2)
    
    @article_merged = Factory(:article)
    @article_merged.body += @article2.body
  end

  
  describe "successful merge" do
    it "has the merged body" do
      new_article = @article.merge_with(@article2.id)
      new_article.body.should == @article_merged.body
    end
    it "has the author of first article" do
      new_article = @article.merge_with(@article2.id)
      new_article.author.should eq @article.author
    end
    it "has the title of first article" do
      new_article = @article.merge_with(@article2.id)
      new_article.title.should eq @article.title
    end
    it "should not exists article2" do
      new_article = @article.merge_with(@article2.id)
      Article.where(id: @article2.id).should_not exist
      Article.where(id: @article_merged.id).should exist
    end
    it "should copy the comments" do
      new_article = @article.merge_with(@article2.id)
      new_article.comments.count.should == 3
    end
    
  end

end

