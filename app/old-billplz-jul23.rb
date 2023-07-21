123

Payment.where(name: "KID BILL",paid: false).where.not(bill_id2: nil).each do |pmt|
pmt.bill_id2 = nil
pmt.save
end

Payment.where(name: "TASKA PLAN",paid: false).where.not(bill_id: nil).each do |pmt|
pmt.bill_id = nil
pmt.save
end


change API - 52342525-733f-4510-81b5-0b458e521498 (old 7aadab0d-b925-4444-aeb9-c3b328b144dd)
change default collection_id ENV['CLT'] - o7huch1p (old hpeyffel)
change billing collection_id ENV['COLLECTION_ID'] - iq5otnuf (old fd5tpciv)

{292=>["vmzubjzi", "hhjl_00l"], 651=>["0ezzveoe", "thxtp_rt"], 46=>["hadn9wk1", "xpgwnxz6"], 47=>["ygqfojqk", "8rfnwyga"], 650=>["obfnvcwc", "frdla_b1"], 592=>["ausdnupf", "nhk5oofy"], 670=>["ytbhkzzt", "y4sbbicc"], 669=>["tst1anol", "o34ihg9b"], 278=>["r_huqpqt", "dgg927mc"], 606=>["x6tqt6qt", "jeshh0ts"], 76=>["cu8i0ksg", "mvvvegbx"], 54=>["wtfyipud", "5vukngkp"], 662=>["vs1bxkqx", "esxnqx08"], 574=>["hekhbe5c", "iwsas7lb"], 658=>["hekhbe5c", "iwsas7lb"], 648=>["csbdntro", "tyqaqwx4"], 286=>["90ubl9ae", "mlty4h3j"], 277=>["739m2rkr", "gsfhtmfy"], 276=>["739m2rkr", "gsfhtmfy"], 666=>["739m2rkr", "gsfhtmfy"], 81=>["llbtfn0b", "luh9e4r6"], 56=>["llbtfn0b", "luh9e4r6"], 55=>["llbtfn0b", "luh9e4r6"]}

ts = {292=>["oxohq4jb", "spyfp9c3"], 651=>["s9lhf6ex", "ii9bq87a"], 46=>["trgxcsbr", "pu1fv3yc"], 47=>["sppd6qcx", "fioydhla"], 650=>["ccskm8yk", "dh0x1rjw"], 592=>["pqu1_mkq", "fs4urduf"], 670=>["gsli0qei", "zv_suzfl"], 669=>["ovuzvv27", "ersphjdz"], 278=>["ma1mzq5h", "togpsnoi"], 606=>["rl4gn7ka", "b4hng1n0"], 76=>["onrqde30", "77vxc5a7"], 54=>["9u80tp74","o6f10yf7"], 662=>["s_kpyigx","uuo7b85_"], 574=>["ibtv03u8","l_qmhgss"], 658=>["xtm4_r51","ob3pgkuj"], 648=>["vxwpd5ct","y471zuj8"], 286=>["hgyxm_hi", "dhc0mdci"], 277=>["xnf0uwle","vp45yhum"], 276=>["bmr3blml","hltkcmhx"], 666=>["jffmkmta","pmstt23x"], 81=>["x5ojpmc5","ooqdxawz"], 56=>["n5pqoknp","firrx05w"], 55=>["03myor4o","ogea0ao0"]}

ts.each do |k,v|
tsk = Taska.find(k)
tsk.collection_id = v[0]
tsk.collection_id2 = v[1]
tsk.save
end

Taska.where(collection_id: "o7huch1p").each do |tsk|
tsk.collection_id = $clt 
tsk.collection_id2 = $clt 
tsk.save
end


