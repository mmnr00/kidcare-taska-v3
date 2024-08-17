# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
# if Rails.env.development?
#   $undiptns = ENV['UNDIPTNS'].split(/\r/)
# elsif Rails.env.production? 
#   $undiptns = ENV['UNDIPTNS'].split(/\n/)
# end

$catgtsk = ["Bahan/ Bekalan/ Inventori",
            "Barang Keperluan Pejabat",
            "Barangan Runcit",
            "Belanjawan Hiburan Awal",
            "Cukai Harta Tanah",
            "Gaji Pekerja",
            "Hutang Lapuk",
            "Iklan dan Pemasaran",
            "Insurans",
            "Kebajikan Pekerja",
            "KWSP Pekerja",
            "Latihan Kakitangan",
            "Lesen/ Yuran/ Permit",
            "Mainan/ Barangan Pelajar",
            "Pajakan",
            "Pelbagai",
            "Pembaikan dan Penyelengaraan",
            "Pembayaran Balik Pekerja",
            "Pembelian Perabot",
            "Pembelian Peralatan",
            "Penambahbaikan Harta Benda",
            "Penambahbaikan Pegangan Pajakan",
            "Pengangkutan",
            "PERKESO Pekerja",
            "Program/Majlis",
            "Sewa Hartanah",
            "Sistem Keselamatan",
            "Susut Nilai",
            "Utiliti/ Telefon",
            "Yuran Langganan dan Keahlian",
            "Yuran Perundangan/ Professional/ Perundingan"
            ]

$taska_old = ENV['TASKA_OLD'].split(',')
$taskabiz = ENV['TASKABIZ']
$cakna21 = ENV['cakna21'].split(',')
$admckn = ENV['admckn'].split(',')

$anisf = [8,46,50,51,54,55,57,60,63,69,71,82,84,90]
$anis2 = [64,66,73,74,75,79,85,87,91,93]
$anis2f = [65,67,76,77,78,80,86,88,92]

$eventpt = {
            "ptns-1"=>["https://kidcare-prod.s3.amazonaws.com/ptns-1.jpeg",
                      "BENGKEL WANITA CAKNA ANAK"]
            }


$my_time = Time.now.in_time_zone('Singapore')

$trial = 30
$expire = 11

if Rails.env.development? || (ENV["ROOT_URL_BILLPLZ"] == "https://kidcare-staging.herokuapp.com/")
  $clt = ENV["CLT"]
elsif Rails.env.production? 
  $clt = ENV["CLT"]
end

$package_price = 	{ "BASIC"=>80,
										"STANDARD"=>150,
										"PREMIUM"=>200,
										"PLATINUM"=>240,
										"PAY PER USE"=>3,
                    "PAY PER USE N"=>3,
                    "MONTHLY FIX" => 50,
									}
#taska discount = percentage(how much they have to pay i.e 40% == t.discount = 0.6)

$package_child = 	{ "BASIC"=>30,
										"STANDARD"=>60,
										"PREMIUM"=>80,
										"PLATINUM"=>100
									}

$month_name = { 1=>"JAN",
								2=>"FEB",
								3=>"MAR",
								4=>"APR",
								5=>"MAY",
								6=>"JUN",
								7=>"JUL",
								8=>"AUG",
								9=>"SEP",
								10=>"OCT",
								11=>"NOV",
								12=>"DEC",
							}
$bank_code =	{ "AFFIN BANK BERHAD"=>"PHBMMYKL",
								"AGROBANK / BANK PERTANIAN MALAYSIA BERHAD"=>"BPMBMYKL",
								"ALLIANCE BANK MALAYSIA BERHAD"=>"MFBBMYKL",
								"AL RAJHI BANKING INVESTMENT CORPORATION (MALAYSIA) BERHAD"=>"RJHIMYKL",
								"AMBANK (M) BERHAD"=>"ARBKMYKL",
								"BANK ISLAM MALAYSIA BERHAD"=>"BIMBMYKL",
								"BANK KERJASAMA RAKYAT MALAYSIA BERHAD"=>"BKRMMYKL",
								"BANK MUAMALAT (MALAYSIA) BERHAD"=>"BMMBMYKL",
								"BANK SIMPANAN NASIONAL BERHAD"=>"BSNAMYK1",
								"CIMB BANK BERHAD"=>"CIBBMYKL",
								"CITIBANK BERHAD"=>"CITIMYKL",
								"HONG LEONG BANK BERHAD"=>"HLBBMYKL",
								"HSBC BANK MALAYSIA BERHAD"=>"HBMBMYKL",
								"MAYBANK / MALAYAN BANKING BERHAD"=>"MBBEMYKL",
								"OCBC BANK (MALAYSIA) BERHAD"=>"OCBCMYKL",
								"PUBLIC BANK BERHAD"=>"PBBEMYKL",
								"RHB BANK BERHAD"=>"RHBBMYKL",
								"STANDARD CHARTERED BANK (MALAYSIA) BERHAD"=>"SCBLMYKX",
								"UNITED OVERSEAS BANK (MALAYSIA) BERHAD"=>"UOVBMYKL", 
							}
$ph_sel19 = {
							1	=>{	1	=>"	New Year's Day	",
									 25 =>"	Thaipusam	"},
              2 => {10 => "CNY",
                    11 => "CNY",
                    12 => "CNY"},
              3 => {28 => "Nuzul Quran"},
              4 => {10 => "Hari Raya Aidifitri",
                    11 => "Hari Raya Aidifitri"},
							5	=>{	1	=>"	Labour Day	",
                    22 =>" Wesak Day  "},
							6	=>{	3	=>"	Agong Birthday	",
                    17 => "Hari Raya Aidiladha"},
              7 =>{ 7 => "Awal Muharram",
                    8 => "Awal Muharram"},
							8	=>{ 31  =>" Merdeka  "},
							9	=>{	16	=>"	Malaysia Day, Maulidur Rasul	",
                    17  =>" Malaysia Day"},
              10 =>{ 31 => "Deepavali"},
							12	=>{	25	=>"	Christmas Day	"},
						}
            
$sel_dun = [" Sungai Air Tawar  " ,
            " Sabak " ,
            " Sungai Panjang  " ,
            " Sekinchan " ,
            " Hulu Bernam " ,
            " Kuala Kubu Baharu " ,
            " Batang Kali " ,
            " Sungai Burong " ,
            " Permatang " ,
            " Bukit Melawati  " ,
            " Ijok  " ,
            " Jeram " ,
            " Kuang " ,
            " Rawang  " ,
            " Taman Templer " ,
            " Sungai Tua  " ,
            " Gombak Setia  " ,
            " Hulu Kelang " ,
            " Bukit Antarabangsa  " ,
            " Lembah Jaya " ,
            " Pandan Indah  " ,
            " Teratai " ,
            " Dusun Tua " ,
            " Semenyih  " ,
            " Kajang  " ,
            " Sungai Ramal  " ,
            " Balakong  " ,
            " Seri Kembangan  " ,
            " Seri Serdang  " ,
            " Kinrara " ,
            " Subang Jaya " ,
            " Seri Setia  " ,
            " Taman Medan " ,
            " Bukit Gasing  " ,
            " Kampung Tunku " ,
            " Bandar Utama  " ,
            " Bukit Lanjan  " ,
            " Paya Jaras  " ,
            " Kota Damansara  " ,
            " Kota Anggerik " ,
            " Batu Tiga " ,
            " Meru  " ,
            " Sementa " ,
            " Selat Klang " ,
            " Bandar Baru Klang " ,
            " Pelabuhan Klang " ,
            " Pandamaran  " ,
            " Sentosa " ,
            " Sungai Kandis " ,
            " Kota Kemuning " ,
            " Sijangkang  " ,
            " Banting " ,
            " Morib " ,
            " Tanjong Sepat " ,
            " Dengkil " ,
            " Sungai Pelek  " ,
            ]



# # ## BILLPLZ LOCAL
# # $billplz_url = "https://billplz-staging.herokuapp.com/api/v3/"
# # $billplz = "https://billplz-staging.herokuapp.com/"
# # $api_key = "6d78d9dd-81ac-4932-981b-75e9004a4f11"
# # $root_url = "http://localhost:3000/"

# # ## BILLPLZ STAGING 
# # $billplz_url = "https://billplz-staging.herokuapp.com/api/v3/"
# # $billplz = "https://billplz-staging.herokuapp.com/"
# # $api_key = "6d78d9dd-81ac-4932-981b-75e9004a4f11"
# # $root_url = "http://kidcare-staging.herokuapp.com/"

# # # ##BILLPLZ PRODUCTION-TRY
# # $billplz_url = "https://billplz-staging.herokuapp.com/api/v3/"
# # $billplz = "https://billplz-staging.herokuapp.com/"
# # $api_key = "6d78d9dd-81ac-4932-981b-75e9004a4f11"
# # $root_url = "http://kidcare-prod.herokuapp.com/"

# # ##BILLPLZ PRODUCTION-REAL
# $billplz_url = "https://www.billplz.com/api/v3/"
# $billplz = "https://www.billplz.com/"
# $api_key = "667aac2a-cdb2-4b44-8ca6-2d26f63d63f3"
# $root_url = "http://kidcare-prod.herokuapp.com/"






