require 'spec_helper'

describe StrokeCounter::Typist::Brain::Interpreter do
  let(:klass) { Struct.new(nil) { include StrokeCounter::Typist::Brain::Interpreter} }
  let(:interpreter) { klass.new }

  describe '.to_katakana' do
    let(:text) { "片仮名" }
    let(:kana) { interpreter.to_katakana(text) }

    test_cases = {
      "片仮名" => 'カタカナ',
      "今日の新聞は分厚い" => 'キョウノシンブンハブアツイ',
      "部分分数分解" => 'ブブンブンスウブンカイ',
      "重箱が重なっている" => 'ジュウバコガカサナッテイル',
    }
    test_cases.each do |jp,result|
      context "when '#{jp}' given" do
        let(:text) { jp }
        it "should return '#{result}' for '#{jp}'" do
          expect(kana).to eq result
        end
      end
    end
  end
end