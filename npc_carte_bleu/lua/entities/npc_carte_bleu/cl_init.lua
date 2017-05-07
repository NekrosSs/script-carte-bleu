include('shared.lua')

for i=10,100 do 
	surface.CreateFont("NekrosFont"..i, {
	font = "Arial", 
	size = i, 
	weight = 2000
})
end 
local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

net.Receive('panel',function()
	local Base = vgui.Create( "DFrame" )
	Base:SetSize( 500, 170 )
	Base:Center()
	Base:SetTitle( "" )
	Base:SetVisible( true )
	Base:SetDraggable( false )
	Base:ShowCloseButton( false )
	Base:MakePopup()
	Base.Paint = function(self,w,h)
	DrawBlur(self, 8)
    	draw.RoundedBox( 5, 0, 0, w, h, Color(125, 125, 125, 125 ) )
        
		draw.RoundedBox(0,0,0,w,35,Color(0,0,0,200))
		
		draw.SimpleText('Que puis-je faire pour vous ?', "NekrosFont30", 250, 40, Color(255,255,255) ,TEXT_ALIGN_CENTER )
	end

local DermaButton = vgui.Create( "DButton", Base) 
	DermaButton:SetSize( Base:GetWide()-10, 35 )
	DermaButton:SetPos( 5, 50+25 )
	DermaButton:SetText( "J'aimerai avoir ma carte bleu" )
	DermaButton:SetFont('NekrosFont25')
	DermaButton:SetTextColor(color_white)
	DermaButton.OnCursorEntered = function(self) DermaButton:SetTextColor(Color(115,115,115)) end
	DermaButton.OnCursorExited = function(self) DermaButton:SetTextColor(color_white) end
    DermaButton.DoClick = function(self)
		net.Start("Npc_carte")
		net.SendToServer()
		Base:Close()
    end
   	DermaButton.Paint = function (self,w,h)            
    	draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
    end

	local DermaButton2 = vgui.Create( "DButton", Base) 
	DermaButton2:SetSize( Base:GetWide()-10, 35 )
	DermaButton2:SetPos( 5, 115 )
	DermaButton2:SetText( "Désolé de vous derangez" )
	DermaButton2:SetFont('NekrosFont25')
	DermaButton2:SetTextColor(color_white)
	DermaButton2.OnCursorEntered = function(self) DermaButton2:SetTextColor(Color(115,115,115)) end
	DermaButton2.OnCursorExited = function(self) DermaButton2:SetTextColor(color_white) end
    DermaButton2.DoClick = function(self)
    	Base:Remove()
	end
    DermaButton2.Paint = function (self,w,h)            
    	draw.RoundedBox(0,0,0,w,h,Color(0,0,0,200))
    end


end)




