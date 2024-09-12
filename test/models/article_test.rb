require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "Draft article returns true for a new article" do
    assert articles(:draft).draft?
  end

  test "draft? returns false for published article" do
    refute articles(:published).draft
  end

  test "draft? returns false for scheduled article" do
    refute articles(:scheduled).draft?
  end

  test "Published? returns true for published article" do
    assert articles(:published).published?
  end

  test "Published? returns false for draft article" do
    refute articles(:draft).published?
  end

  test "Published? returns false for scheduled article" do
    refute articles(:scheduled).published?
  end

  test "Scheduled? returns true for scheduled article" do
    assert articles(:scheduled).scheduled?
  end

  test "Scheduled? returns false for draft article" do
    refute articles(:draft).scheduled?
  end

  test "Scheduled? returns false for published article" do
    refute articles(:published).scheduled?
  end
end
