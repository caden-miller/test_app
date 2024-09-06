# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreatingBooks', type: :system do
  before do
    driven_by(:rack_test)
  end
  context 'integration test' do
    it 'creates and displays a book with a title' do
      visit '/books/new'

      fill_in 'Title', with: 'Test Book'

      click_on 'Create Book'

      expect(page).to have_content('Successfully created a book')
      expect(page).to have_content('Test Book')

      book = Book.order('id').last
      expect(book.title).to eq('Test Book')
    end

    it 'fails to create a book with no title' do
      visit '/books/new'

      click_on 'Create Book'

      expect(page).to have_content("Failed to create a book, title can't be blank.")
    end

    it 'creates and displays a book with a title and author' do
      visit '/books/new'

      fill_in 'Title', with: 'Test Book'
      fill_in 'Author', with: 'Test Author'

      click_on 'Create Book'

      expect(page).to have_content('Successfully created a book')
      expect(page).to have_content('Test Book')
      expect(page).to have_content('Test Author')

      book = Book.order('id').last
      expect(book.title).to eq('Test Book')
      expect(book.author).to eq('Test Author')
    end

    it 'creates and displays a book with a title and price' do
      visit '/books/new'

      fill_in 'Title', with: 'Test Book'
      fill_in 'Price', with: '10.01'

      click_on 'Create Book'

      expect(page).to have_content('Successfully created a book')
      expect(page).to have_content('Test Book')
      expect(page).to have_content('10.01')

      book = Book.order('id').last
      expect(book.title).to eq('Test Book')
      expect(book.price).to eq(10.01)
    end

    it 'creates and displays a book with a title and published_date' do
      visit '/books/new'

      fill_in 'Title', with: 'Test Book'
      select '2024', from: 'book_published_date_1i'
      select 'September', from: 'book_published_date_2i'
      select '2', from: 'book_published_date_3i'

      click_on 'Create Book'

      expect(page).to have_content('Successfully created a book')
      expect(page).to have_content('Test Book')
      expect(page).to have_content('2024-09-02')

      book = Book.order('id').last
      expect(book.title).to eq('Test Book')
      expect(book.published_date).to eq(Date.new(2024, 9, 2))
    end
  end
end

