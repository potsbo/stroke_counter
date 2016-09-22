require 'spec_helper'

describe StrokeCounter::Typist::Brain do
  let(:brain) { StrokeCounter::Typist::Brain.new(mode: mode) }
  let(:mode) { :normal }
  describe '#to_keys' do
    let(:keys) { brain.to_keys(input) }
    let(:input) { "" }

    describe 'one to one patterns' do
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

    describe 'contracted sounds' do
      test_cases = {
        'きゃきゅきょ'      => 'kyakyukyo',
        'きゃききゅきぇきょ' => 'kyakikyukyekyo',
        'しゃしゅしょ'      => 'syasyusyo',
        'しゃししゅしぇしょ' => 'syasisyusyesyo',
        'ちゃちゅちょ'      => 'tyatyutyo',
        'ちゃちちゅちぇちょ' => 'tyatityutyetyo',
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

    describe 'normal sentence' do
      test_cases = {
        'きょうはめちゃくちゃいいてんきってかんじですね。' => 'kyouhametyakutyaiitenkittekanzidesune.',
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

    context 'when mode is dvorak' do
      let(:mode) { :dvorak }
      describe 'one to one patterns' do
        test_cases = {
          'あいうえお' => "'ueo",
          'かきくけこ' => 'cacicuceco',
          'さしすせそ' => 'sasisuseso',
          'たちつてと' => 'tatituteto',
          'なにぬねの' => 'naninuneno',
          'はひふへほ' => 'hahihuheho',
          'まみむめも' => 'mamimumemo',
          'やゆよ'    => 'fafufo',
          'らりるれろ' => 'rarirurero',
          'わをん'    => 'wawq',
          'あんぱん'    => ';v;',
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

      describe 'normal sentence' do
        test_cases = {
          'きょうはめちゃくちゃいいてんきってかんじですね。' => "cn,hametnacutnaytjcittec;zidesunel.",
          'がっつりけいしょくひんだいこうひょうはつばいちゅう。' => "gatturic.shocuhxd'c,hn,hatub'tnpl.",
          'あいんしゅたいんはかみれべるのぶつりがくしゃ' => "axshutaxhacamireberunobuturigacusha",
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
  end
end
