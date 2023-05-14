import { LightningElement, api, wire } from "lwc";
import communityId from "@salesforce/community/Id"
import communityBasePath from "@salesforce/community/basePath"
import getCategories from "@salesforce/apex/Categories.getCategories";
import getContent from "@salesforce/apex/Content.getContent";


export default class Navbar extends LightningElement {
    @wire(getCategories, {
        communityId: communityId,
        CategoryId: null,
    })
	handleCategories({ error, data }) {
		console.log('CommunityId:: ', communityId);
		if (data) {
			this.categories = JSON.parse(data);
		} else if (error) {
			console.log(error);
		}
	}

	// get logo image cms
	@wire(getContent, {
		communityId: communityId,
        contentId: "_logoImageCMS",
        pageParam: 0,
        pageSize: 1,
        language: "en_US",
        showAbsoluteUrl: true,
    })
	handleContent({ error, data }) {
		if (data) {
			this.logoImageURL = data.source.url;
		} else if (error) {
			console.log(error);
		}
	}


	_logoImageCMS
	set logoImageCMS(value) {
		console.log("Image Val: ", value);
		this._logoImageCMS = value;
	}
	@api
	get logoImageCMS() {
		return this._logoImageCMS;
	}


	_logoImageURL
	set logoImageURL(value) {
		this._logoImageURL = value;
	}
	get logoImageURL() {
		return this._logoImageURL;
	}


	_linkOneText
	set linkOneText(value) {
		this._linkOneText = value
	}
	@api
	get linkOneText() {
		return this._linkOneText
	}


	_linkOneURL
	set linkOneURL(value) {
		this._linkOneURL = value;
	}
	@api
	get linkOneURL() {
		return this._linkOneURL
	}


	_linkTwoText
	set linkTwoText(value) {
		this._linkTwoText = value;
	}
	@api
	get linkTwoText() {
		return this._linkTwoText;
	}


	_linkTwoURL
	set linkTwoURL(value) {
		this._linkTwoURL = value;
	}
	@api
	get linkTwoURL() {
		return this._linkTwoURL;
	}


	_linkThreeText
	set linkThreeText(value) {
		this._linkThreeText = value;
	}
	@api
	get linkThreeText() {
		return this._linkThreeText;
	}


	_linkThreeURL
	set linkThreeURL(value) {
		this._linkThreeURL = value;
	}
	@api
	get linkThreeURL() {
		return this._linkThreeURL;
	}


	_linkFourText
	set linkFourText(value) {
		this._linkFourText = value;
	}
	@api
	get linkFourText() {
		return this._linkFourText;
	}


	_linkFourURL
	set linkFourURL(value) {
		this._linkFourURL = value;
	}
	@api
	get linkFourURL() {
		return this._linkFourURL;
	}


	_linkFiveText
	set linkFiveText(value) {
		this._linkFiveText = value;
	}
	@api
	get linkFiveText() {
		return this._linkFiveText;
	}


	_linkFiveURL
	set linkFiveURL(value) {
		this._linkFiveURL = value;
	}
	@api
	get linkFiveURL() {
		return this._linkFiveURL;
	}


	_linkSixText
	set linkSixText(value) {
		this._linkSixText = value;
	}
	@api
	get linkSixText() {
		return this._linkSixText;
	}

	_linkSixURL
	set linkSixURL(value) {
		this._linkSixURL = value;
	}
	@api
	get linkSixURL() {
		return this._linkSixURL;
	}

	_categories
	set categories(value) {
		this._categories = value;
	}
	get categories() {
		return this._categories;
	}

	get homeLink() {
		return communityBasePath ? communityBasePath : "/";
	}

}