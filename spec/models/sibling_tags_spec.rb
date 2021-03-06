require File.dirname(__FILE__) + '/../spec_helper'

describe "Sibling Tags" do
  scenario :sibling_pages
  
  describe "<r:siblings>" do
    it "should expand its contents" do
      page(:sneezy).should render('<r:siblings>true</r:siblings>').as('true')
    end
  end
  describe "<r:siblings:each>" do
    it "should order the page siblings by published_at" do
      page(:sneezy).should render('<r:siblings:each><r:title/> </r:siblings:each>').as('Happy Grumpy Dopey Doc Bashful ')
    end
    it "should allow siblings to be ordered by the 'by' attribute" do
      page(:sneezy).should render('<r:siblings:each by="title"><r:title /> </r:siblings:each>').as('Bashful Doc Dopey Grumpy Happy ')
    end
    it "should allow siblings to be sorted with the 'order' attribute when using 'by'" do
      page(:sneezy).should render('<r:siblings:each by="slug" order="asc"><r:title /> </r:siblings:each>').as('Bashful Doc Dopey Grumpy Happy ')
    end
    it "should exclude the current page" do
      page(:sneezy).should render('<r:siblings:each><r:title/> </r:siblings:each>').as('Happy Grumpy Dopey Doc Bashful ')
    end
    it "should exclude unpublished pages" do
      page(:sneezy).should render('<r:siblings:each><r:title/> </r:siblings:each>').as('Happy Grumpy Dopey Doc Bashful ')
    end
  end  
      
  describe "<r:if_siblings>" do
    it 'should output its contents if the current page has siblings' do
      page(:happy).should render('<r:if_siblings>true</r:if_siblings>').as('true')
    end
    it 'should not output its contents if the current page has no siblings' do
      page(:solo).should render('<r:if_siblings>false</r:if_siblings>').as('')
    end
  end
  
  describe "<r:unless_siblings>" do
    it 'should output its contents if the current page has no siblings' do
      page(:solo).should render('<r:unless_siblings>true</r:unless_siblings>').as('true')
    end
    it 'should not output its contents if the current page has siblings' do
      page(:happy).should render('<r:unless_siblings>false</r:unless_siblings>').as('')
    end
  end
  
  describe "<r:siblings:next>" do
    it 'should output nothing if the current page has no siblings' do
      page(:home).should render('<r:siblings:next>false</r:siblings:next>').as('')
    end
    it 'should output its contents if the current page has a sibling next in order' do
      page(:doc).should render('<r:siblings:next>true</r:siblings:next>').as('true')
    end
    it 'should not output its contents if the current page has siblings, but not next in order' do
      page(:bashful).should render('<r:siblings:next>true</r:siblings:next>').as('')
    end
    it "should set the scoped page to the next page in order" do
      page(:doc).should render('<r:siblings:next><r:title /></r:siblings:next>').as('Bashful')
    end
  end
  
  describe "<r:siblings:each_before>" do
    it "should render its contents for each sibling following the current one in order" do
      page(:dopey).should render('<r:siblings:each_before><r:title /> </r:siblings:each_before>').as('Grumpy Happy Sneezy ')
    end
  end
  
  describe "<r:siblings:each_after>" do
    it "should render its contents for each sibling following the current one in order" do
      page(:dopey).should render('<r:siblings:each_after><r:title /> </r:siblings:each_after>').as('Doc Bashful ')
    end
  end
  
  describe "<r:siblings:previous>" do
    it 'should output nothing if the current page has no siblings' do
      page(:home).should render('<r:siblings:previous>false</r:siblings:previous>').as('')
    end
    it 'should output its contents if the current page has a sibling previous in order' do
      page(:doc).should render('<r:siblings:previous>true</r:siblings:previous>').as('true')
    end
    it 'should not output its contents if the current page has siblings, but not previous in order' do
      page(:sneezy).should render('<r:siblings:previous>true</r:siblings:previous>').as('')
    end
    it "should set the scoped page to the previous page in order" do
      page(:doc).should render('<r:siblings:previous><r:title /></r:siblings:previous>').as('Dopey')
    end
  end
  
  describe "<r:sibling:if_next>" do
    it "should output its contents if the current page has a sibling next in order" do
      page(:doc).should render('<r:siblings:if_next>true</r:siblings:if_next>').as('true')
    end
    it "should not output its contents if the current page has no sibling next in order" do
      page(:bashful).should render('<r:siblings:if_next>true</r:siblings:if_next>').as('')
    end
  end
  
  describe "<r:siblings:unless_next>" do
    it "should output its contents if the current page has no sibling next in order" do
      page(:bashful).should render('<r:siblings:unless_next>true</r:siblings:unless_next>').as('true')
    end
    it "should not output its contents if the current page has a sibling next in order" do
      page(:doc).should render('<r:siblings:unless_next>true</r:siblings:unless_next>').as('')
    end
  end
  
  describe "<r:siblings:if_previous>" do
    it "should output its contents if the current page has a sibling previous in order" do
      page(:doc).should render('<r:siblings:if_previous>true</r:siblings:if_previous>').as('true')
    end
    it "should not output its contents if the current page has no sibling previous in order" do
      page(:sneezy).should render('<r:siblings:if_previous>true</r:siblings:if_previous>').as('')
    end
  end
  
  describe "<r:siblings:unless_previous>" do
    it "should output its contents if the current page has no sibling previous in order" do
      page(:sneezy).should render('<r:siblings:unless_previous>true</r:siblings:unless_previous>').as('true')
    end
    it "should not output its contents if the current page has a sibling previous in order" do
      page(:doc).should render('<r:siblings:unless_previous>true</r:siblings:unless_previous>').as('')
    end
  end

  private

  def page(symbol = nil)
    if symbol.nil?
      @page ||= pages(:assorted)
    else
      @page = pages(symbol)
    end
  end
  
end