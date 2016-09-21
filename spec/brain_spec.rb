require 'spec_helper'

describe StrokeCounter::Typist::Brain do
  let(:brain) { StrokeCounter::Typist::Brain.new }
  describe '#to_keys' do
    let(:keys) { brain.to_keys(input) }
    let(:input) { "" }

    test_cases = {
      'あいうえお' => 'aiueo',
      'かきくけこ' => 'kakikukeko',
      'さしすせそ' => 'sasisuseso',
      'たちつてと' => 'tatituteto',
      'なにぬねの' => 'naninuneno',
      'はひふへほ' => 'hahihuheho',
      'まみむめも' => 'mamimumemo',
      'やゆよ'    => 'yayuyo',
      'らりるれろ' => 'rarirurero',
      'わをん' => 'wawon',
    }
    test_cases.each do |jp,en|
      context "when '#{jp}' given" do
        let(:input) { jp }
        it "should return #{en}" do
          expect(keys).to eq en
        end
      end
    end

  end
end
