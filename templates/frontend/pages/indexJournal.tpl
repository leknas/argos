{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2022 SOAP2 Project
 * Distributed under the GNU GPL v2.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="container container-homepage-issue page-content{if $homepageImage} container-hompege-issue-before-image{/if}">

{* display announcements before full issue *}
	{if $numAnnouncementsHomepage && $announcements|@count}
	<section class="row homepage-announcements p-md-2">
		<h2 class="sr-only">{translate key="announcement.announcementsHome"}</h2>
		{foreach from=$announcements item=announcement}
			<article class="col-md homepage-announcement p-3 m-3">
				<h3 class="homepage-announcement-title">{$announcement->getLocalizedTitle()|escape}</h3>
				<div><small class="homepage-announcement-date">{$announcement->getDatePosted()|date_format:$dateFormatLong}</small></div>
				{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
					<a class="btn btn-primary" href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
						{capture name="more" assign="more"}{translate key="common.more"}{/capture}
						{translate key="common.more"}
					</a>
				
			</article>
		{/foreach}
	</section>
	{/if}
	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="row justify-content-center homepage-additional-content my-3">
			<div class="col-lg-12 p-4">{$additionalHomeContent}</div>
		</div>
	{/if}

	{if $issue}
<!--		<h2 class="h5 homepage-issue-current">
			{translate key="journal.currentIssue"}
		</h2>
		<div class="h1 homepage-issue-identifier">
			{$issue->getIssueSeries()|escape}
		</div>
		<div class="h6 homepage-issue-published">
			{translate key="plugins.themes.healthSciences.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
		</div>
-->
		{* make the entire block conditional if there aren't any additional issue data *}
		{if  $issue->getLocalizedCoverImageUrl() || $issue->hasDescription() || $issueGalleys}
			<div class="row justify-content-center homepage-issue-header my-3">
				{if $issue->getLocalizedCoverImageUrl()}
					<div class="col-lg-3">
						<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
							<img class="img-fluid homepage-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
						</a>
					</div>
				{/if}
				{if $issue->hasDescription() || $journalDescription || $issueGalleys}
					<div class="col-lg-{if $issue->getLocalizedCoverImageUrl()}9{else}12{/if} px-0">
						<div class="homepage-issue-description-wrapper p-3">
							{if $issue->hasDescription()}
								<div class="homepage-issue-description">
									<div class="h2">
										{if $issue->getLocalizedTitle()}
											{$issue->getLocalizedTitle()|escape}
										{else}
											{translate key="plugins.themes.healthSciences.issueDescription"}
										{/if}
									</div>
									{$issue->getLocalizedDescription()|strip_unsafe_html}
									<div class="homepage-issue-description-more">
										<a class="btn btn-primary" href="{url op="view" page="issue" path=$issue->getBestIssueId()}">{translate key="common.more"}</a>
									</div>
								</div>
							{elseif $journalDescription}
								<div class="homepage-journal-description long-text" id="homepageDescription">
									{$journalDescription|strip_unsafe_html}
								</div>
								<div class="homepage-description-buttons hidden" id="homepageDescriptionButtons">
									<a class="homepage-journal-description-more hidden" id="homepageDescriptionMore">{translate key="common.more"}</a>
									<a class="homepage-journal-description-less hidden" id="homepageDescriptionLess">{translate key="common.less"}</a>
								</div>
							{/if}
							{if $issueGalleys}
								<div class="homepage-issue-galleys">
									<div class="h3">
										{translate key="issue.fullIssue"}
									</div>
									{foreach from=$issueGalleys item=galley}
										{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
									{/foreach}
								</div>
							{/if}
						</div>
					</div>
				{/if}
			</div>
		{/if}

	{/if}

	{if $issue}
		<div class="row issue-wrapper{if $homepageImage && $issue->hasDescription()} issue-full-data{elseif $homepageImage && $issue->getLocalizedCoverImageUrl()} issue-image-cover{elseif $homepageImage} issue-only-image{/if}">
			<div class="col-12 px-0">
				{include file="frontend/objects/issue_toc.tpl" sectionHeading="h3"}
			</div>
		</div>

		<div class="text-center">
			<a class="btn" href="{url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}">
				{translate key="journal.viewAllIssues"}
			</a>
		</div>
	{/if}


</div>

{include file="frontend/components/footer.tpl"}
