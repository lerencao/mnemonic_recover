require 'bip44'


word_path = File.join(File.absolute_path(__dir__), "words/english.txt")
words = File.read(word_path).strip.split("\n")
# puts words.size

missing_index = ARGV[0].to_i - 1
input_words = ARGV[1..-1]

candidate_mnemonics = words.map do |w|
  list = input_words[0...missing_index] + [w] + input_words[missing_index..-1]
  list.join(' ')
end

# puts 'Candidate mnemonics:'
# candidate_mnemonics.each do |m|
#   puts m
# end

address_with_mnemonics = candidate_mnemonics.map do |mnemonic|
  wallet = Bip44::Wallet.from_mnemonic(mnemonic, "m/44'/60'/0'/0")
  [wallet.ethereum_address, mnemonic]
end

candidate_addresses = address_with_mnemonics.map { |addr, _| addr }.join(",")

fetch_balance_url = "https://api.etherscan.io/api?module=account&action=balancemulti&address=#{candidate_addresses}&tag=latest&apikey=YourApiKeyToken"

puts "Prepare to fetch url: #{fetch_balance_url}"

require 'http'
resp = HTTP.get(fetch_balance_url).to_s

puts resp

if 1 != resp['status'].to_i
  raise   "api error when call #{fetch_balance_url}"
end

balances = resp['result'].filter { |s| s['balance'].to_i >= 0 }.map { |s| s['balance'] = s['balance'].to_i }.to_h
if balances.empty?
  puts "no account with balance found"
else
  balances.each do |addr, balance|
    puts "Found, account: #{addr}, balance: #{balance}"
    puts "      mnemonic: #{address_with_mnemonics[addr]}"
  end
end
