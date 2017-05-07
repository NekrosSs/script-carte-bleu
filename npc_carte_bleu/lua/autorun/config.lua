AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

util.AddNetworkString("Npc_carte")
util.AddNetworkString("panel")

function ENT:Initialize()
	self:SetModel("models/gman_high.mdl")
	self:SetSolid( SOLID_BBOX )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal()
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:CapabilitiesAdd( CAP_TURN_HEAD )
	self:SetUseType( SIMPLE_USE )
end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" && IsValid(Caller) && Caller:IsPlayer() then
		net.Start("panel")
		net.Send(Caller)	
	end
end

function ENT:OnTakeDamage(dmg)
	return false
end

net.Receive("Npc_carte",function(lenght,ply)
 if file.Exists( "nekros_carte/"..ply:UniqueID()..".txt", "DATA" ) then
  ply:ChatPrint('Vous avez déjà pris votre carte.')
 else
  if ply:getDarkRPVar('money') >= ConfigCarteNpc.PriceCarte then
   ply:Give(ConfigCarteNpc.GiveWeapon)
   ply:addMoney(-ConfigCarteNpc.PriceCarte)

   file.Write( "nekros_carte/"..ply:UniqueID()..".txt", "Yes" )
  else
  	 	ply:ChatPrint("Vous n'avez pas assez d'argent.")
  end
 	end
end)

hook.Add("PlayerSpawn","NekroscartePlayerspawn",function(ply)															
	if file.Exists("nekros_carte/"..ply:UniqueID()..".txt", "DATA") then
		ply:Give(ConfigCarteNpc.GiveWeapon)
	end	
end)	

