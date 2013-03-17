class RemoteAssociationPaginationProxie
  include Enumerable

  attr_accessor :total_pages

  def self.for_request_with_page(&block)
    new(&block)
  end

  def initialize(&request_action)
    @request_action = request_action
    @page = 1
    @total_pages = 0
  end

  def each(&block)
    populate_from_requested_action_for_current_page
    @items.each { |item| yield item }
  end

  def empty?
    populate_from_requested_action_for_current_page
    @items.empty?
  end

  def fetch
    populate_from_requested_action_for_current_page
    self
  end

  def for_page(page)
    @page = page.to_i
    @items = nil
    self
  end

  private

  def populate_from_requested_action_for_current_page
    @items ||= @request_action.call(@page, self)
  end
end