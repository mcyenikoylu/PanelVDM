<%@ Control Language="C#" ClassName="SliderWidget" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e) {
        //if(!IsPostBack)
        //    imageSlider.ImageSourceFolder = "~/Images/UploadImageSlider/";
        DMProjectWeb.DMPortalEntities db = new DMProjectWeb.DMPortalEntities();
        var list = db.S_DuyurularSlider(-1).Where(c => c.Aktif == true).OrderBy(c => c.SiraNo).ToList();
        if(list.Count>0)
        {
            foreach (var item in list)
            {
                imageSlider.Items.Add(item.ResimAdi);
            }
        }
    }
</script>
<style type="text/css">
        .dxisControl {
            margin: 8px 0 10px 0;
        }
</style>
<dx:ASPxImageSlider ID="imageSlider" runat="server" ClientInstanceName="imageSlider" EnableTheming="false" ShowNavigationBar="true">
    <ClientSideEvents Init="function(s, e) { s.Focus(); }" />
    <SettingsSlideShow AutoPlay="true" />
    <SettingsImageArea EnableLoopNavigation="false"
        ImageSizeMode="ActualSizeOrFit"
        AnimationType="Fade"
        NavigationDirection="Horizontal"
        ItemTextVisibility="OnMouseOver"
        NavigationButtonVisibility="OnMouseOver" />
    <SettingsNavigationBar Position="Bottom"
        Mode="Thumbnails"
        ThumbnailsModeNavigationButtonVisibility="OnMouseOver"
        ThumbnailsNavigationButtonPosition="Inside"
        PagingMode="Single" />
    <SettingsBehavior AllowMouseWheel="true"
        EnablePagingGestures="false"
        EnablePagingByClick="Auto"
        ImageLoadMode="Auto"
        ExtremeItemClickMode="SelectAndSlide" />
</dx:ASPxImageSlider>