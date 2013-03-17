require 'spec_helper'

describe RemoteAssociationPaginationProxie do

  it "should more descriptive way to instantiate it " do
    RemoteAssociationPaginationProxie.should respond_to(:for_request_with_page)
  end

  it "should behave like an enumerable" do
    proxy_instance = RemoteAssociationPaginationProxie.new {}
    proxy_instance.should respond_to(:each)
  end

  it "should allow the page to be set" do
    proxy_instance = RemoteAssociationPaginationProxie.new {}
    proxy_instance.should respond_to(:for_page)
  end

  it "should be empty when there are no items" do
    proxy_instance = RemoteAssociationPaginationProxie.new { [] }
    proxy_instance.should be_empty
  end

  it "should not be empty when there are items" do
    proxy_instance = RemoteAssociationPaginationProxie.new { [1] }
    proxy_instance.should_not be_empty
  end

  it "should return self from #for_page to enable chaining" do
    proxy_instance = RemoteAssociationPaginationProxie.new {}
    proxy_instance.for_page(1).should == proxy_instance
  end

  it "should return self from #fetch to enable chaining" do
    proxy_instance = RemoteAssociationPaginationProxie.new {}
    proxy_instance.fetch.should == proxy_instance
  end

  describe "yielding to the request block" do

    before(:each) do
      @proxy_instance = RemoteAssociationPaginationProxie.for_request_with_page do |page|
        [9999 * page]
      end
    end

    it "should use each to iterate over the return value from the block passed to initialize" do
      @proxy_instance.each do |item|
        item.should == 9999
      end
    end

    it "should yield the page" do
      @proxy_instance.for_page(24)

      @proxy_instance.each do |item|
        item.should == 239976
      end
    end

    it "should rerun the block when yielded multiple times with different pages" do
      @proxy_instance.for_page(5)
      @proxy_instance.each do |item|
        item.should == 49995
      end

      @proxy_instance.for_page(17)
      @proxy_instance.each do |item|
        item.should == 169983
      end
    end

    it "should also yield the proxy so the total_pages can be set" do
      @proxy_instance = RemoteAssociationPaginationProxie.for_request_with_page do |page, proxy|
        proxy.total_pages = 6
        [9999 * page]
      end

      @proxy_instance.fetch
      @proxy_instance.total_pages.should == 6
    end
  end
end