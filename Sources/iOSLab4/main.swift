import Foundation
import FoundationNetworking

func getRate(fromCurrency rate:String)-> Double?{
   let url = URL(string: "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
   do{
      let content:String = try String(contentsOf:url!)
      let searchString = "\"\(rate)\" rate=\""

      if let range1 = content.range(of:searchString){
         let startIndex = range1.upperBound

         var i = 0
         while isValidChar(for: content[content.index(startIndex, offsetBy:i)]) {
            // print("is valid for char \(content[content.index(startIndex, offsetBy:i)])")
            i += 1
         }
         let subString =  content[startIndex..<content.index(startIndex, offsetBy: i)]
         // print(subString)
         // print(type(of:subString))
         if let _number = Double(subString){
            return _number
         }
      }
   }catch _{
      print("error")
   }
   return nil
}


func isValidChar(for char: Character) -> Bool{
   let num = char.unicodeScalars.map{$0.value}[0]
   if (num >= 48 && num <= 57) || num == 46 {
      return true
   }else{
      return false
   }
}

print(getRate(fromCurrency: "USD")!)

print(getRate(fromCurrency: "GBP")!)