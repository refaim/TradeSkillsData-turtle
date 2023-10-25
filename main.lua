---@param base Entity[]
---@param diff Entity[]
---@return Entity[]
local function patch(base, diff)
    ---@type table<number, Entity>
    local id_to_entity = {}

    for _, entity in ipairs(base) do
        id_to_entity[entity.id] = entity
    end

    for _, entity in ipairs(diff) do
        id_to_entity[entity.id] = entity
    end

    local result = {}
    for _, entity in pairs(id_to_entity) do
        tinsert(result, entity)
    end
    return result
end

TRADE_SKILLS_DATA["MIN_PATCH_LEVEL"] = TRADE_SKILLS_DATA_TURTLE["MIN_PATCH_LEVEL"]
TRADE_SKILLS_DATA["MAX_PATCH_LEVEL"] = TRADE_SKILLS_DATA_TURTLE["MAX_PATCH_LEVEL"]
TRADE_SKILLS_DATA["CURRENT_PATCH_LEVEL"] = TRADE_SKILLS_DATA_TURTLE["CURRENT_PATCH_LEVEL"]

for _, profession in pairs({"Blacksmithing", "Engineering", "Leatherworking", "Tailoring"}) do
    for _, category in pairs({"items", "skills"}) do
        TRADE_SKILLS_DATA[category][profession] = patch(TRADE_SKILLS_DATA[category][profession], TRADE_SKILLS_DATA_TURTLE[category][profession])
    end
end

for _, entity in pairs({"factions", "npcs", "quests", "zones"}) do
    TRADE_SKILLS_DATA[entity] = patch(TRADE_SKILLS_DATA[entity], TRADE_SKILLS_DATA_TURTLE[entity])
end
