# Copyleft (C) Ákos Kovács
#
# Unit test for bkk_crypt.rb using RSpec
# Run with: 'rspec bkk_crypt_spec.rb'
require './bkk_crypt.rb'

RSpec.describe BKKCrypt, '#bkk_crypt' do
    MSG_ATTAC = "Haxxor protec,\nbut he also attac"
    MSG_SAFE = "Safe and secure"

    it 'can encrypt empty message' do
        expect(BKKCrypt::bkk_crypt('')).to eq([''])
        expect(''.bkk_crypt).to eq('')
    end

    it 'can encrypt multiple empty messages' do
        expect(BKKCrypt::bkk_crypt('', '', '')).to eq(['', '', ''])
        expect(['', '', ''].bkk_crypt).to eq(['', '', ''])
    end

    it 'can encrypt a non-empty message' do
        expect(BKKCrypt::bkk_crypt(MSG_ATTAC)).to eq([MSG_ATTAC])
        expect(MSG_ATTAC.bkk_crypt).to eq(MSG_ATTAC)
    end

    it 'can encrypt a non-empty message' do
        expect(BKKCrypt::bkk_crypt(MSG_ATTAC, MSG_SAFE)).to eq([MSG_ATTAC, MSG_SAFE])
        expect([MSG_ATTAC, MSG_SAFE].bkk_crypt).to eq([MSG_ATTAC, MSG_SAFE])
    end

    it 'can encrypt non-string data' do
        expect(BKKCrypt::bkk_crypt(42)).to eq([42])
        expect(23.bkk_crypt).to eq(23)
    end
end
