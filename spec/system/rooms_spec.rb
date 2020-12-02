require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を5つDBに追加する
    @message = []
    5.times do |i|
      @message[i] = FactoryBot.build(:message)
      fill_in 'message_content', with: @message[i].content
      expect{click_on('送信')}.to change{ Message.count }.by(1)
    end

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを確認する
    expect{click_on('チャットを終了する')}.to change{ Message.count }.by(-5)
    5.times do |i|
      expect(page).to have_no_content(@message[i].content)
    end

    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path

  end
end