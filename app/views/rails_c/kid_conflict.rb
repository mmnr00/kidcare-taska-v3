arr = {}
Kid.all.each do |kd|

kid_dup = Kid.where(ic_1: kd.ic_1, ic_2: kd.ic_2, ic_3: kd.ic_3).where.not(id: kd.id)

if kid_dup.present?

pres = false

arr.each do |k,v|

if k == kd.id
pres = true
end
v.each do |nm|
if nm == kd.id
pres = true
end
end

end

arr[kd.id] = kid_dup.ids unless pres

end

end

###############

arr = {10=>[9], 31=>[178], 14=>[37], 131=>[65], 913=>[462], 971=>[1097], 91=>[161], 17=>[58], 1826=>[1595], 125=>[203], 104=>[102], 143=>[220], 142=>[221], 137=>[136], 219=>[208], 218=>[210, 209], 234=>[233], 485=>[841], 496=>[2034], 489=>[519], 297=>[1726], 337=>[499], 345=>[344], 353=>[861], 387=>[531], 393=>[850], 394=>[859], 366=>[1170, 1304], 365=>[1169], 364=>[515], 399=>[1309], 397=>[857], 415=>[860], 418=>[864], 420=>[862], 419=>[863], 411=>[1192], 412=>[1190], 413=>[1191], 400=>[1310], 512=>[494], 425=>[500], 518=>[488], 536=>[731], 529=>[1729], 1200=>[1326], 1325=>[1262], 540=>[740], 953=>[952], 632=>[1249], 910=>[1308], 738=>[797], 761=>[748], 780=>[1383, 1382, 1997, 1998, 2003, 1996], 660=>[888], 1327=>[1181], 845=>[1305], 846=>[1306], 877=>[1307], 881=>[1505], 1334=>[1180], 1335=>[1142], 1026=>[1125], 1328=>[1333], 1047=>[1048], 1209=>[1211], 1208=>[1210], 1331=>[1196], 1110=>[1129], 2000=>[1784], 1128=>[1123], 1197=>[1424], 1859=>[1420], 1835=>[1537], 1836=>[1441], 1605=>[1530], 1386=>[1485], 1403=>[1673], 1456=>[1463], 1449=>[1841], 1452=>[1457], 1721=>[1662], 1470=>[1471], 1479=>[1497], 1732=>[1737], 1528=>[1609], 1558=>[1584], 1592=>[1591], 1596=>[1531], 1686=>[1687]}
arr2=[]
arr.each do |k,v|
if v.count > 1
#puts "#{k} - #{v}"
end
arr2 << k
v.each do |kd|
arr2<<kd
end
end

arr3=[]
arr2.each do |kd|
arr3 << kd unless Kid.find(kd).taska.present?
end

arr3.each do |kd|
puts "#{Kid.find(kd).parent_id}"
end

###################

arr = {10=>[9], 31=>[178], 14=>[37], 131=>[65], 913=>[462], 971=>[1097], 91=>[161], 17=>[58], 1826=>[1595], 125=>[203], 104=>[102], 143=>[220], 142=>[221], 137=>[136], 219=>[208], 218=>[210, 209], 234=>[233], 485=>[841], 496=>[2034], 489=>[519], 297=>[1726], 337=>[499], 345=>[344], 353=>[861], 387=>[531], 393=>[850], 394=>[859], 366=>[1170, 1304], 365=>[1169], 364=>[515], 399=>[1309], 397=>[857], 415=>[860], 418=>[864], 420=>[862], 419=>[863], 411=>[1192], 412=>[1190], 413=>[1191], 400=>[1310], 512=>[494], 425=>[500], 518=>[488], 536=>[731], 529=>[1729], 1200=>[1326], 1325=>[1262], 540=>[740], 953=>[952], 632=>[1249], 910=>[1308], 738=>[797], 761=>[748], 780=>[1383, 1382, 1997, 1998, 2003, 1996], 660=>[888], 1327=>[1181], 845=>[1305], 846=>[1306], 877=>[1307], 881=>[1505], 1334=>[1180], 1335=>[1142], 1026=>[1125], 1328=>[1333], 1047=>[1048], 1209=>[1211], 1208=>[1210], 1331=>[1196], 1110=>[1129], 2000=>[1784], 1128=>[1123], 1197=>[1424], 1859=>[1420], 1835=>[1537], 1836=>[1441], 1605=>[1530], 1386=>[1485], 1403=>[1673], 1456=>[1463], 1449=>[1841], 1452=>[1457], 1721=>[1662], 1470=>[1471], 1479=>[1497], 1732=>[1737], 1528=>[1609], 1558=>[1584], 1592=>[1591], 1596=>[1531], 1686=>[1687]}
arr2=[]

arr.each do |k,v|
k1 = Kid.find(k)
puts "#{k1.name}-#{k} (#{k1.taska_id}-#{k1.classroom_id}) = #{k1.parent_id}"
puts "\n"

v.each do |v1|
k1 = Kid.find(v1)
puts "#{k1.name}-#{v1} (#{k1.taska_id}-#{k1.classroom_id}) = #{k1.parent_id}"
end
puts "\n"
puts "\n"
end

######################

arr = {10=>[9], 31=>[178], 14=>[37], 131=>[65], 913=>[462], 971=>[1097], 91=>[161], 17=>[58], 1826=>[1595], 125=>[203], 104=>[102], 143=>[220], 142=>[221], 137=>[136], 219=>[208], 218=>[210, 209], 234=>[233], 485=>[841], 496=>[2034], 489=>[519], 297=>[1726], 337=>[499], 345=>[344], 353=>[861], 387=>[531], 393=>[850], 394=>[859], 366=>[1170, 1304], 365=>[1169], 364=>[515], 399=>[1309], 397=>[857], 415=>[860], 418=>[864], 420=>[862], 419=>[863], 411=>[1192], 412=>[1190], 413=>[1191], 400=>[1310], 512=>[494], 425=>[500], 518=>[488], 536=>[731], 529=>[1729], 1200=>[1326], 1325=>[1262], 540=>[740], 953=>[952], 632=>[1249], 910=>[1308], 738=>[797], 761=>[748], 780=>[1383, 1382, 1997, 1998, 2003, 1996], 660=>[888], 1327=>[1181], 845=>[1305], 846=>[1306], 877=>[1307], 881=>[1505], 1334=>[1180], 1335=>[1142], 1026=>[1125], 1328=>[1333], 1047=>[1048], 1209=>[1211], 1208=>[1210], 1331=>[1196], 1110=>[1129], 2000=>[1784], 1128=>[1123], 1197=>[1424], 1859=>[1420], 1835=>[1537], 1836=>[1441], 1605=>[1530], 1386=>[1485], 1403=>[1673], 1456=>[1463], 1449=>[1841], 1452=>[1457], 1721=>[1662], 1470=>[1471], 1479=>[1497], 1732=>[1737], 1528=>[1609], 1558=>[1584], 1592=>[1591], 1596=>[1531], 1686=>[1687]}

arr_fin = []

arr.each do |k,v|
arr2=[]
k1 = Kid.find(k)
arr2<<"#{k1.name}-#{k} (#{k1.taska_id}-#{k1.classroom_id}) = #{k1.parent_id}"


v.each do |v1|
k1 = Kid.find(v1)
arr2<<"#{k1.name}-#{v1} (#{k1.taska_id}-#{k1.classroom_id}) = #{k1.parent_id}"
end
arr_fin<<arr2
end

########################

arr = []
Kid.all.each do |kd|

kid_dup = Kid.where(ic_1: kd.ic_1, ic_2: kd.ic_2, ic_3: kd.ic_3).where.not(id: kd.id)

if kid_dup.present?
kid_dup.each do |kdp|
arr<<kdp.id unless (kdp.payments.present? || kdp.taska.present? || (arr.include?kdp.id))
end #kdpeach
end #kid_dup

end #loop kid

arr.each do |kd|
if Kid.find(kd).parent_id == 1
puts "#{Kid.find(kd).name} (#{Kid.find(kd).parent_id})"
end
end











