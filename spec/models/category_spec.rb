require 'spec_helper'

RSpec.describe Category, type: :model do
  before do
    Category.destroy_all
    MenuItem.destroy_all
    @category_1 = Category.create!(name: '菓子パン', position: 1)
    @category_2 = Category.create!(name: 'バゲット', position: 2)
  end

  example 'find_one' do
    category = Category.where(:name, :==, '菓子パン').find_one
    expect(category.name).to eq '菓子パン'

    category = Category.where(:name, :==, 'バゲット').find_one
    expect(category.name).to eq 'バゲット'

    category = Category.where(:name, :==, 'カンパーニュ').find_one
    expect(category).to be_nil

    query = Category.where(:name, :==, '菓子パン')
    category = query.find_one
    expect(category.name).to eq '菓子パン'

    category = query.where(:position, :==, 1).find_one
    expect(category.name).to eq '菓子パン'

    category = query.where(:position, :==, 2).find_one
    expect(category).to be_nil
  end

  example 'find_one!' do
    category = Category.where(:name, :==, '菓子パン').find_one!
    expect(category.name).to eq '菓子パン'

    expect { Category.where(:name, :==, 'カンパーニュ').find_one! }.to raise_error(ActiveRecord::RecordNotFound)
  end

  example 'find_many' do
    categories = Category.where(:position, :>=, 1).find_many
    expect(categories.map(&:name)).to contain_exactly('菓子パン', 'バゲット')

    categories = Category.where(:position, :>=, 2).find_many
    expect(categories.map(&:name)).to contain_exactly('バゲット')

    categories = Category.where(:position, :>=, 3).find_many
    expect(categories).to be_empty

    categories = Category.where(:position, :==, 2).where(:name, :==, 'バゲット').find_many
    expect(categories.map(&:name)).to contain_exactly('バゲット')
  end

  describe 'destroy_all' do
    context 'without where' do
      example do
        Category.destroy_all
        expect(Category.all.count).to eq 0
      end
    end
    context 'with where' do
      example do
        Category.where(:position, :>=, 2).destroy_all
        expect(Category.all.count).to eq 1
        expect(Category.all.map(&:name)).to contain_exactly('菓子パン')
      end
    end
  end

  describe 'order' do
    context 'without where' do
      example do
        categories = Category.order(:position).find_many
        expect(categories.map(&:name)).to eq ['菓子パン', 'バゲット']

        categories = Category.order(:position, :desc).find_many
        expect(categories.map(&:name)).to eq ['バゲット', '菓子パン']
      end
    end
    context 'with where' do
      example do
        categories = Category.where(:position, :>=, 0).order(:position).find_many
        expect(categories.map(&:name)).to eq ['菓子パン', 'バゲット']

        categories = Category.where(:position, :>=, 0).order(:position, :desc).find_many
        expect(categories.map(&:name)).to eq ['バゲット', '菓子パン']

        categories = Category.order(:position).where(:position, :>=, 0).find_many
        expect(categories.map(&:name)).to eq ['菓子パン', 'バゲット']
      end
    end
  end

  example 'exists?' do
    expect(Category.where(:name, :==, '菓子パン').exists?).to be true
    expect(Category.where(:name, :==, 'バゲット').exists?).to be true
    expect(Category.where(:name, :==, 'カンパーニュ').exists?).to be false

    query = Category.where(:name, :==, '菓子パン')
    expect(query.exists?).to be true
    expect(query.where(:position, :==, 1).exists?).to be true
    expect(query.where(:position, :==, 2).exists?).to be false
  end

  describe 'first' do
    context 'without order' do
      example do
        category = Category.first
        expect(category).to be_instance_of Category

        categories = Category.first(2)
        expect(categories.map(&:name)).to contain_exactly('菓子パン', 'バゲット')
      end
    end
    context 'with order' do
      example do
        category = Category.order(:position, :desc).first
        expect(category.name).to eq 'バゲット'

        categories = Category.order(:position, :desc).first(2)
        expect(categories.map(&:name)).to eq ['バゲット', '菓子パン']
      end
    end
  end

  describe '#destroy_with_menu_items' do
    before do
      MenuItem.create!(name: 'あんぱん', category_id: @category_1.id)
      MenuItem.create!(name: 'ジャムぱん', category_id: @category_1.id)
      MenuItem.create!(name: 'メロンぱん', category_id: @category_2.id)
    end

    example do
      @category_1.destroy_with_menu_items
      expect(Category.all.map(&:name)).to eq ['バゲット']
      expect(MenuItem.all.map(&:name)).to eq ['メロンぱん']
    end
  end
end
