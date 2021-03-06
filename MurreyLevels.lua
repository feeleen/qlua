Settings={
Name = "*Murrey Levels",
period=64,
stepback = 0,
usegap = 0,
line={
{
Name = "[-2/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,0, 255)
},
{
Name = "[-1/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,191, 191)
},
{
Name = "[0/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(0,128, 255)
},
{
Name = "[1/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(218,188, 18)
},
{
Name = "[2/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,0, 128)
},
{
Name = "[3/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(120,220, 235)
},
{
Name = "[4/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(128,128, 128)--green
},
{
Name = "[5/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(120,220, 235)
},
{
Name = "[6/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,0, 128)
},
{
Name = "[7/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(218,188, 18)
},
{
Name = "[8/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(0,128, 255)
},
{
Name = "[+1/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,191, 191)
},
{
Name = "[+2/8]",
Type =TYPE_CANDLE,-- = LINE --линии  = DASH -- тире  = POINT -- точки
Width = 2,
Color = RGB(255,0, 255)
},

}}


function Init()
	myMurreyMath = MurreyMath()
	return #Settings.line
end

function OnCalculate(index)

	return myMurreyMath(index, Settings.period, Settings.stepback, Settings.usegap)

end

function MurreyMath()
	
	local Buffer1={}
	local Buffer2={}
	local Buffer3={}
	local Buffer4={}
	local Buffer5={}
	local Buffer6={}
	local Buffer7={}
	local Buffer8={}
	local Buffer9={}
	local Buffer10={}
	local Buffer11={}
	local Buffer12={}
	local Buffer13={}
		
	return function(ind, _p, _s, _g)
		local index = ind
		local period = _p
		local stepback = _s
		local usegap = _g
		
		local m = 0		
		local h = 0
		local fractal = 0
		local range = 0
		local sum = 0
		local mn = 0
		local mx = 0
		local octave = 0
		
		local indexshift = index - (period - 1)
		
		if index == 1 then
			 
			 Buffer1={}
			 Buffer2={}
			 Buffer3={}
			 Buffer4={}
			 Buffer5={}
			 Buffer6={}
			 Buffer7={}
			 Buffer8={}
			 Buffer9={}
			 Buffer10={}
			 Buffer11={}
			 Buffer12={}
			 Buffer13={}
			
			 Buffer1[index]=0
			 Buffer2[index]=0
			 Buffer3[index]=0
			 Buffer4[index]=0
			 Buffer5[index]=0
			 Buffer6[index]=0
			 Buffer7[index]=0
			 Buffer8[index]=0
			 Buffer9[index]=0
			 Buffer10[index]=0
			 Buffer11[index]=0
			 Buffer12[index]=0
			 Buffer13[index]=0
			 
			return nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
			
		end
 		
       
		if index < (Size()-3) then 
			return nil 
		end
		
		for nn = 1, 13 do
			SetValue(Size()-4, nn, nil)
		end
 		
		m = lowestLow(index,(period+stepback))
		h = highestHigh(index,(period+stepback))
		fractal = DetermineFractal(h)
		range = h-m
		sum = math.floor(math.log(fractal/range)/math.log(2))
		octave=fractal*(math.pow(0.5,sum))
		
		mn = math.floor(m/octave)*octave
		mx = mn+(2*octave)		
		if (mn+octave) >= h then
			mx = mn+octave
		end
		
-- calculating xx
--x2
   local x2=0
   if ((m>=(3*(mx-mn)/16+mn)) and (h<=(9*(mx-mn)/16+mn))) then
      x2=mn+(mx-mn)/2
	end  
--x1
   local x1=0
   if ((m>=(mn-(mx-mn)/8)) and (h<=(5*(mx-mn)/8+mn)) and (x2==0)) then
      x1=mn+(mx-mn)/2
	end  

--x4
   local x4=0
   if ((m>=(mn+7*(mx-mn)/16)) and (h<=(13*(mx-mn)/16+mn))) then
      x4=mn+3*(mx-mn)/4
	end  

--x5
   local x5=0
   if ((m>=(mn+3*(mx-mn)/8)) and (h<=(9*(mx-mn)/8+mn)) and (x4==0)) then
      x5=mx
	end  

--x3
   local x3=0
   if ((m>=(mn+(mx-mn)/8)) and (h<=(7*(mx-mn)/8+mn)) and (x1==0) and (x2==0) and (x4==0) and (x5==0)) then
      x3=mn+3*(mx-mn)/4
	end  

--x6
   local x6=0
   if (x1+x2+x3+x4+x5)==0 then
      x6=mx
	end  

   local finalH=x1+x2+x3+x4+x5+x6
-- calculating yy
--y1
   local y1=0
   if x1>0 then
      y1=mn
	end  

--y2
   local y2=0
   if x2>0 then
      y2=mn+(mx-mn)/4
	end  

--y3
   local y3=0
   if x3>0 then
      y3=mn+(mx-mn)/4
	end  

--y4
   local y4=0
   if x4>0 then
      y4=mn+(mx-mn)/2
	end  

--y5
   local y5=0
   if x5>0 then
      y5=mn+(mx-mn)/2
	end  

--y6
   local y6=0
   if finalH>0 and (y1+y2+y3+y4+y5)==0 then
      y6=mn
 	end  
  
   local finalL = y1+y2+y3+y4+y5+y6
   
   local dmml = (finalH-finalL)/8
   
    
   Buffer1[index]=(finalL-dmml*2) ---2/8
   
   Buffer2[index]=Buffer1[index]+dmml
   Buffer3[index]=Buffer2[index]+dmml
   Buffer4[index]=Buffer3[index]+dmml
   Buffer5[index]=Buffer4[index]+dmml
   Buffer6[index]=Buffer5[index]+dmml
   Buffer7[index]=Buffer6[index]+dmml
   Buffer8[index]=Buffer7[index]+dmml
   Buffer9[index]=Buffer8[index]+dmml
   Buffer10[index]=Buffer9[index]+dmml
   Buffer11[index]=Buffer10[index]+dmml
   Buffer12[index]=Buffer11[index]+dmml
   Buffer13[index]=Buffer12[index]+dmml

   if usegap and Buffer1[index-1]~=nil and Buffer1[index] ~= Buffer1[index-1] then
		return nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
   end
   
	return Buffer1[index], Buffer2[index], Buffer3[index], Buffer4[index], Buffer5[index], Buffer6[index], Buffer7[index], Buffer8[index], Buffer9[index], Buffer10[index], Buffer11[index], Buffer12[index], Buffer13[index]   
		
				
	end
end

function DetermineFractal(v)
  
   if v<=250000 and v>25000 then
      return 100000
   end
   if v<=25000 and v>2500 then
      return 10000
   end
   if v<=2500 and v>250 then
      return 1000
   end
   if v<=250 and v>25 then
      return 100
   end
   if v<=25 and v>12.5 then
      return 12.5
   end
   if v<=12.5 and v>6.25 then
      return 12.5
   end
   if v<=6.25 and v>3.125 then
      return 6.25
   end
   if v<=3.125 and v>1.5625 then
      return 3.125
   end
   if v<=1.5625 and v>0.390625 then
      return 1.5625
   end
   if v<=0.390625 and v>0 then
      return 0.1953125
   end
   
   return 0
   
 end

function round(num, idp)
	if idp and num then
	   local mult = 10^(idp or 0)
	   if num >= 0 then return math.floor(num * mult + 0.5) / mult
	   else return math.ceil(num * mult - 0.5) / mult end
	else return num end
end
  
function highestHigh(index, period)

	if index == 1 then
		return 0
	else

		local highestHigh = H(index)
		
		for i = math.max(index - period, 2), index, 1 do
			
			if H(i) > highestHigh then
				highestHigh = H(i)
			end
			
		end
	
		return highestHigh 
	
	end
end

function lowestLow(index, period)

	if index == 1 then
		return 0
	else

		local lowestLow = L(index)
		
		for i = math.max(index - period, 2), index, 1 do
						
			if L(i) < lowestLow then
				lowestLow = L(i)
			end
			
		end
	
		return lowestLow 
	
	end
end
