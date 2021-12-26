tsk_id = Hash.new

Taska.all.each do |tsk|
if tsk.expire.present? && ((tsk.expire.to_date - Date.today).to_i > -182)
tsk_id[tsk.id] = [tsk.collection_id, tsk.collection_id2]
end
end

{277=>["myzsfzp5", "czcx2oaa","739m2rkr","gsfhtmfy"], 
286=>["6vs70l7u", "pajvgfjy","90ubl9ae","mlty4h3j"], 
652=>["x7w_y71n", "x7w_y71n"], 
276=>["myzsfzp5", "czcx2oaa","739m2rkr","gsfhtmfy"], 
653=>["x7w_y71n", "x7w_y71n"], 
592=>["yrqg50ta", "qe1h1lqp","ausdnupf","nhk5oofy"], 
287=>["keslypic", "vfzz2z3c","llbtfn0b","luh9e4r6"], 
53=>["v8xfop7w", "h3xuyihc","tngfcnv9","mhknjvc5"], 
55=>["keslypic", "vfzz2z3c","llbtfn0b","luh9e4r6"], 
81=>["b6i_le1j", "qo3bjia0","xns9660v","nhfd2z4v"], 
76=>["zvfa1md1", "orjc1zxi","cu8i0ksg","mvvvegbx"], 
4=>["1y3glusm", nil], 
52=>["1y3glusm", "1y3glusm"], 
56=>["keslypic", "vfzz2z3c","llbtfn0b","luh9e4r6"], 
80=>["b6i_le1j", "qo3bjia0","xns9660v","nhfd2z4v"], 
46=>["6e_pr8fb", "nseb_5tl","w38adzhf","6d8nxjfp"], 
597=>["2fgjssjp", "hkdlabya","togccz0v","l21ovy_0"], 
598=>["2fgjssjp", "hkdlabya","togccz0v","l21ovy_0"], 
576=>["ub300ny_", "vnfp1qmz","cmp20qsp","lc_ni0o0"], 
278=>["odyzqnth", "pq4ou0ad","r_huqpqt","dgg927mc"], 
54=>["6mjb__dj", "kwkamuzp","wtfyipud","5vukngkp"], 
650=>["x7w_y71n", "x7w_y71n"], 
606=>["0ewi8kz6", "aip0shg2","4hrsivrt","quondlrj"], 
648=>["zqmkdesx", "xikynidw","csbdntro","tyqaqwx4"], 
574=>["q09wholt", "mw0mkqyy","hekhbe5c","iwsas7lb"], 
651=>["a5svd6gn", "90m8znk3","lzojkzuq","zy8idbol"], 
47=>["6e_pr8fb", "nseb_5tl","w38adzhf","6d8nxjfp"], 
292=>["adblcxjf", "ckwa5mqg","vmzubjzi","hhjl_00l"]}