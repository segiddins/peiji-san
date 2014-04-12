# -*- encoding : utf-8 -*-
require File.expand_path('../test_helper', __FILE__)

class ArbitraryClass
  # required methods

  def all
    self
  end

  def count
    (PeijiSan::ENTRIES_PER_PAGE * 2) + 1
  end

  attr_accessor :assigned_limit
  def limit(count)
    derived = dup
    derived.assigned_limit = count
    derived
  end

  attr_accessor :assigned_offset
  def offset(count)
    derived = dup
    derived.assigned_offset = count
    derived
  end
end

describe "An arbitrary class extended by PeijiSan" do
  before do
    @subject = ArbitraryClass.new
    @subject.extend(PeijiSan)
  end

  it "can page" do
    derived = @subject.page(2)
    derived.page_count.must_equal 3
    derived.current_page.must_equal 2
    derived.assigned_limit.must_equal PeijiSan::ENTRIES_PER_PAGE
    derived.assigned_offset.must_equal PeijiSan::ENTRIES_PER_PAGE
  end
end
