# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CreatingBooks', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'unit test' do
    it 'creates a book with a title' do
      book = Book.new(title: 'Test Book')

      expect { book.save }.to change { Book.count }.by(1)

      expect(Book.last.title).to eq('Test Book')
    end

    it 'creates a book with no title and fails' do
      book = Book.new(title: nil)

      expect(book).not_to be_valid

      expect { book.save }.not_to(change { Book.count })

      expect(book.errors[:title]).to include("can't be blank")
    end

    it 'creates a book with a title and author' do
      book = Book.new(title: 'Test Book', author: 'Test Author')

      expect { book.save }.to change { Book.count }.by(1)

      expect(Book.last.title).to eq('Test Book')
      expect(Book.last.author).to eq('Test Author')
    end

    it 'creates a book with a title and price' do
      book = Book.new(title: 'Test Book', price: '10.01')

      expect { book.save }.to change { Book.count }.by(1)

      expect(Book.last.title).to eq('Test Book')
      expect(Book.last.price).to eq(10.01)
    end

    it 'creates a book with a title and published_date' do
      book = Book.new(title: 'Test Book', published_date: Date.new(2024, 9, 2))

      expect { book.save }.to change { Book.count }.by(1)

      expect(Book.last.title).to eq('Test Book')
      expect(Book.last.published_date).to eq(Date.new(2024, 9, 2))
    end
  end
end

