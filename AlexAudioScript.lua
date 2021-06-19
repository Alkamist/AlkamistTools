local itemPaddingTime = 0.020

function alexAudioScript()
    reaper.PreventUIRefresh(1)
    reaper.Undo_BeginBlock()

    local chunks = {}
    local numberOfChunks = reaper.CountTrackMediaItems(reaper.GetSelectedTrack(0, 0))
    local numberOfSelectedTracks = reaper.CountSelectedTracks(0)

    for i = 1, numberOfChunks do
        chunks[i] = {}
        for j = 1, numberOfSelectedTracks do
            local currentTrack = reaper.GetSelectedTrack(0, j - 1)
            local currentItem = reaper.GetTrackMediaItem(currentTrack, i - 1)
            chunks[i][j] = currentItem
        end
    end

    local alignmentPosition = reaper.GetMediaItemInfo_Value(chunks[1][1], "D_POSITION")
    for i = 1, #chunks do
        local longestLengthInChunk = reaper.GetMediaItemInfo_Value(chunks[i][1], "D_LENGTH")
        for j = 1, #chunks[i] do
            local item = chunks[i][j]
            local itemLength = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
            if itemLength > longestLengthInChunk then
                longestLengthInChunk = itemLength
            end
            reaper.SetMediaItemPosition(item, alignmentPosition, false)
        end
        for j = 1, #chunks[i] do
            local item = chunks[i][j]
            reaper.SetMediaItemLength(item, longestLengthInChunk, false)
        end
        reaper.Main_OnCommand(40289, 0) -- Unselect all items
        reaper.SetMediaItemSelected(chunks[i][1], true)
        reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_REGIONSFROMITEMS"), 0)
        alignmentPosition = alignmentPosition + longestLengthInChunk + itemPaddingTime
    end

    reaper.PreventUIRefresh(-1)
    reaper.UpdateArrange()
    reaper.Undo_EndBlock("Alex Audio Script", -1)
end

alexAudioScript()